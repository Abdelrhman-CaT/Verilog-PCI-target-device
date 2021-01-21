// declaration of clock generator with clock cycle = 10 ns
module ClockGen (Clock);
output Clock;
reg Clock;
initial
Clock = 0;
always
#5 Clock = ~Clock;
endmodule   

// declaration of pci target
module pci_target (clk, rst, ad, cbe ,frame, irdy, trdy, devsel);
input clk, rst;
input irdy;
input [3:0]cbe;
input frame;
inout [31:0] ad;   // inout because this port is used for both read and write operations
output reg trdy;
output reg devsel;

parameter read = 4'b0010;
parameter write = 4'b0011;
parameter ad1reg = 32'h00000300;
parameter ad2reg = 32'h00000301;
parameter ad3reg = 32'h00000302;

reg willUseBuffer;
reg [4:0] spareBufferReadPointer;
reg bufferUsed;
reg [4:0] spareBufferWritePointer;
reg [1:0] transferedData;
reg [1:0] startingReg;
reg [31:0] data;
reg [31:0] memory [0:2];
reg [31:0] spareBuffer [0:31];
reg [1:0] memPointerRead;
reg [1:0] memPointerWrite;
reg [3:0] operation_from_cbe;
reg [31:0]dataMask;
reg addrChecked;   // marks that the address has been checked correctly and the following input to ad will be treated as data
reg [1:0] count;   // used to make devsel in medium mode
assign ad = (operation_from_cbe == read && ~trdy)?data : 32'bz;   // switch ad between input mode and output mode based on the operation

always @(posedge clk)
begin
	if(~frame && ~addrChecked && (ad == ad1reg || ad == ad2reg || ad == ad3reg))  // checks if the address hasn't been checked yet and the input of ad matches the pci target's address
	begin
	addrChecked <= 1;   // means that the address is checked correctly
	count <= 1;	
	operation_from_cbe <= cbe;   // store the current value of cbe to be the value of the control lines for the operations
	if(ad == ad1reg)
	begin
		memPointerRead <= 0;
		memPointerWrite <= 0;
		startingReg <= 0;
	end
	else if(ad == ad2reg)
	begin
		memPointerRead <= 1;
		memPointerWrite <= 1;	
		startingReg <= 1;
	end
	else if(ad == ad3reg)
	begin
		memPointerRead <= 2;
		memPointerWrite <= 2;
		startingReg <= 2;
	end	
	end
	if(frame && willUseBuffer)
	begin
	addrChecked <= 1;
	end
	else if(frame)
	begin
	addrChecked <= 0;
	end
	
	if(operation_from_cbe == read)
	begin
		if(~trdy && ~irdy)  // marks that the transaction is ongoing
			begin
				if(bufferUsed == 1)
				begin
					spareBufferReadPointer <= spareBufferReadPointer + 1;
					if(spareBufferReadPointer == spareBufferWritePointer)
					begin
						memPointerRead <= memPointerRead + 1;
					end
				end
				else
				begin
					memPointerRead <= memPointerRead + 1;
				end
			end
	end
	else if(operation_from_cbe == write && (~irdy && ~trdy))
	begin
		if(bufferUsed == 1)
		begin
			dataMask = {{8{cbe[3]}}, {8{cbe[2]}}, {8{cbe[1]}}, {8{cbe[0]}}};   // creating a mask from the cbe input value. 
			//we used non-blocking assignments because we need that mask for the statement below
			memory[memPointerWrite] <= ad & dataMask;  // store the data input from ad but it is anded with the mask that is created above
			
			memPointerWrite = memPointerWrite + 1; // increase the pointer used to write into pci target's memory
			transferedData <= transferedData + 1;
		end
		if(~trdy && ~irdy)
			begin
			dataMask = {{8{cbe[3]}}, {8{cbe[2]}}, {8{cbe[1]}}, {8{cbe[0]}}};   // creating a mask from the cbe input value. 
			//we used non-blocking assignments because we need that mask for the statement below
			memory[memPointerWrite] <= ad & dataMask;  // store the data input from ad but it is anded with the mask that is created above
			
			memPointerWrite = memPointerWrite + 1; // increase the pointer used to write into pci target's memory
			transferedData <= transferedData + 1;
			end
	end

	// set the devsel to medium mode in case of read or write operation
	if ((operation_from_cbe == read || operation_from_cbe == write) && count == 1)
	begin
            count <= 2;
	end
end

always @(negedge clk or negedge rst)
begin
	if(~rst)
	begin  // actions done in case of reset
	trdy <= 1;
	devsel <= 1;
	addrChecked <= 0;
	count <= 0;
	memPointerRead <= 0;
	memPointerWrite <= 0;
	transferedData <= 0;
	spareBufferWritePointer <= 0;
	spareBufferReadPointer <= 0;
	bufferUsed <= 0;
	willUseBuffer <= 0;
	end
	else 
	begin
			if(addrChecked && count == 2 && operation_from_cbe == read) // if the address is correct and the operation is read
			begin
				trdy <= 0;
				devsel <= 0;  // set at medium mode

				if(bufferUsed == 1)
				begin
					if(spareBufferReadPointer < spareBufferWritePointer)
					begin
						data <= spareBuffer[spareBufferReadPointer];
					end
					else
					begin
						data <= memory[memPointerRead];
					end
				end
				else
				begin
					if(memPointerRead > 2)
					begin 
						memPointerRead = 0;
					end
					data <= memory[memPointerRead];
				end

				
				
			end
			else if(addrChecked && count == 2 && operation_from_cbe == write) // if the address is correct and the operation is write
			begin
				devsel <= 0; // set at medium mode
				if(transferedData <3)
				begin
					trdy <= 0;
					if(~bufferUsed)
					begin
						if(memPointerWrite > 2)
						begin
							memPointerWrite <= 0;
						end
					end
				end
				else if(transferedData == 3)
				begin
					trdy <= 1;  // if the memory of the pci target is full, the trdy will be set to 1
					willUseBuffer <= 1;
				end
			end
			else if(addrChecked == 0)  // means that the frame is 1
			begin
			trdy <= 1;
			devsel <= 1;
			count <= 0;
			memPointerRead <= 0;
			transferedData <= 0;
			spareBufferReadPointer <= 0;
			end
		
	end
end

genvar i;
generate for(i=0; i<3; i=i+1)
always @(posedge clk)
begin
	if(trdy == 1 && transferedData == 3)
	begin
		spareBuffer[spareBufferWritePointer] <= memory[i];
		spareBufferWritePointer = spareBufferWritePointer + 1;
		if(i == 2)
		begin
			transferedData <= 0;
			bufferUsed <= 1;
			willUseBuffer <= 0;
		end
	end
end
endgenerate


endmodule   
