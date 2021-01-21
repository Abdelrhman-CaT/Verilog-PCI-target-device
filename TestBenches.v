// Testcases

`include "SourceCode.v"

// master calls the address of the first register and writes one data then read it from the target
module TB1;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#10
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#10
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule

// master calls the address of the second register and writes one data then read it from the target
module TB2;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000301;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#10
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000301;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#10
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule


// master calls the address of the third register and writes one data then read it from the target
module TB3;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000302;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#10
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000302;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#10
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule

// master calls an address outside the range of the target device and tries to write one data then calls the address of  
//the first registe to read the data that the master thought he wrotes successfully
module TB4;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000303;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#10
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#10
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule

// master calls the address of the first register and writes 3 data then the master reads those data
module TB5;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;

#10
adReg = 12;
cbe = 4'b1111;
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
cbe = 4'b1111;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule

// master calls the address of the first register and writes 3 data but irdy is raised for a certain time
// during the write operation then it is asserted to 0 again to continue writing then the master reads those data
module TB6;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;

#10
irdy = 1;
cbe = 4'b1111;

#20
irdy = 0;
adReg = 12;
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
cbe = 4'b1111;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule

// master calls the address of the first register and writes 3 data but irdy is raised for a certain time
// during the write operation then it is asserted to 0 again to continue writing then the master reads those data
// but during the read operation, the master raises irdy for a certain time then asserts it to 0 again to continue reading 
module TB7;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;

#10
irdy = 1;
cbe = 4'b1111;

#20
irdy = 0;
adReg = 12;
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
irdy = 1;
cbe = 4'b1111;

#10
irdy = 0;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule

// master calls the address of the first register and writes 3 data then the master reads those data
// but during the read operation, the master raises irdy for a certain time then asserts it to 0 again to continue reading 
module TB8;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;

#10
adReg = 12;
cbe = 4'b1111;
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
irdy = 1;
cbe = 4'b1111;

#10
irdy = 0;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule


// master calls the address of the first register and writes 3 data then the master reads those data
// but the frame at the read operation remains 0 after the reception of the 3 data
module TB9;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;

#10
adReg = 12;
cbe = 4'b1111;
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
cbe = 4'b1111;

#10
cbe = 4'b0011;

#10
cbe = 4'b1111;

#10
cbe = 4'b0011;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule


// master calls the address of the first register and writes 4 data "more than the capacity of the 
// memory of the target" then the master reads those data
module TB10;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;

#10
adReg = 12;
cbe = 4'b1111;

#10
adReg = 13;
cbe = 4'b0011;
frame = 1;

#20
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
cbe = 4'b1111;

#10
cbe = 4'b0011;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule


// master calls the address of the first register and writes 3 data but raises the frame before writing the third data ,
// then the master reads the written data
module TB11;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;
frame = 1;

#10
adReg = 12;
cbe = 4'b1111;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
cbe = 4'b1111;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule



// master calls the address of the first register and writes 3 data then the master reads those data
// but the master raises the frame just after it reads the second data
module TB12;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;

#10
adReg = 12;
cbe = 4'b1111;
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule


// master calls the address of the first register and writes one data then the master calls the address of the first register
// to read that data
// then the master calls the address of the second register then writes one data then the master calls the address of the first register
// to read the two data in the first and the second registers
// then the master calls the address of the third register then writes one data in it 
// then calls the address of the first register to read the 3 data in the first, second and third registers
module TB13;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#10
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#10
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;
write = 1;

#10
frame = 0;
adReg = 32'h00000301;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 11;
cbe = 4'b1111;

#10
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;
write = 1;

#10
frame = 0;
adReg = 32'h00000302;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 12;
cbe = 4'b1111;

#10
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
cbe = 4'b1111;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule


// master calls the address of the first register and writes 4 data "more than the capacity of the 
// memory of the target" 
// But during the writing, irdy is raised for a certain duration then asserted again to 0 to continue writing
// then the master calls the address of the first register to read those data
module TB14;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000300;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;

#10
adReg = 12;
cbe = 4'b1111;

#10
irdy = 1;
cbe = 4'b0011;

#20
irdy = 0;
adReg = 13;
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
cbe = 4'b1111;

#10
cbe = 4'b0011;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule

// Master calls for the address of the second register and enters 3 pieces of data, 
//then the master calls the address of the first register to read the written data
module TB15;
reg rst;
reg frame;
wire [31:0]adWire;
reg [31:0]adReg;
reg write;
reg [3:0]cbe;
reg irdy;
assign adWire = (write == 1)?adReg: 32'bz;

initial
begin
write = 1;
frame = 1;
irdy = 1;
rst = 1;

#10
rst = 0;

#10
rst = 1;

$monitor("time=%t, frame=%b, adWire=%h, cbe=%b, irdy=%b, trdy=%b, devsel=%b \n",$time,frame,adWire,cbe,irdy,trdy,devsel);

frame = 0;
adReg = 32'h00000301;
cbe = 4'b0011;

#10
irdy = 0;
adReg = 10;
cbe = 4'b1111;

#20
adReg = 11;
cbe = 4'b0011;

#10
adReg = 12;
cbe = 4'b1111;
frame = 1;

#10
adReg = 32'bz;
cbe = 4'bz;
irdy = 1;

#10
frame = 0;
adReg = 32'h00000300;
cbe = 4'b0010;

#10
irdy = 0;
write = 0;
cbe = 4'b1111;

#20
cbe = 4'b0011;

#10
cbe = 4'b1111;
frame = 1;

#10
irdy =1;
cbe = 4'bz;
adReg = 32'bz;

end
ClockGen c1(clk);
pci_target p1(clk, rst, adWire, cbe, frame, irdy, trdy, devsel);
endmodule
