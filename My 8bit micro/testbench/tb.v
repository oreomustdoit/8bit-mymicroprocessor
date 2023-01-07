module tb;

reg [71:0] machine_code;
reg clk=0,rst=1;
wire[2:0]flag_cmp;
wire[7:0] regis[0:3];
wire[3:0] prgm_cnt;

always #10 clk=!clk;
integer i,k;

top DUT(machine_code,clk,rst,regis,flag_cmp,prgm_cnt);

 initial
 begin
 rst=1;#1;rst=0;
  for(k=0;k<=15;k=k+1)
 begin
 DUT.M1.memory_bank[k]=0;
 end
 DUT.M1.memory_bank[3]=8'd2;
 DUT.M1.memory_bank[4]=8'd10;
 
 @(posedge clk);
  for(i=0;i<=15;i=i+1)
 begin
 $display("Mem%1d  : %d",i,DUT.M1.memory_bank[i]);
 end

 machine_code= 72'b00000000_00000011_00110100_00100001_01001101_11011000_00000100_00100101_10101001;
 
 repeat(20) @(posedge clk);
 $finish;
 
 





 
 

 end
 endmodule