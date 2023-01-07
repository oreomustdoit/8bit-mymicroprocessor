module my_micro(instruction,clk,rst,regis,flag_cmp);

input clk,rst;
output reg [2:0]flag_cmp;
output reg [7:0] regis[0:3];

input [7:0] instruction;
parameter LD=4'b0000,ST=4'b0001,MR=4'b0011,MI=4'b0010,SUM=4'b0100,

          SMI=4'b1100,SB=4'b0101,SBI=4'b1101,CM=4'b0111,CMI=4'b1111,ANR=4'b0110,ANI=4'b1110,

          ORR=4'b1000,ORI=4'b1001,XRR=4'b1010,XRI=4'b1011;
reg [7:0]memory_bank[15:0];
reg [3:0] opcode,immediate_lsm;
reg immediate_am,sign_am;
reg [7:0]immediate_am_use,immediate_am_logic;
integer i,j,source,destination;
		  
always @* 
begin
source= instruction[1:0];
destination=instruction[3:2];
opcode=instruction[7:4];
immediate_am=instruction[0];
immediate_am_use={7'd0,immediate_am};
sign_am=instruction[1];
immediate_am_logic={{6{instruction[1]}},{instruction[1:0]}};

immediate_lsm= instruction[3:0];


end

always @(posedge clk or posedge rst)
begin
if(rst) 
begin

flag_cmp<=0;
for(i=0;i<=3;i=i+1)
begin
regis[i]<=0;
end
for(j=0;j<=15;j=j+1)
begin
memory_bank[j]<=0;
end
end

else
begin

case(opcode)
LD: begin
    regis[0]<=memory_bank[immediate_lsm];
	
	end
ST: begin
    memory_bank[immediate_lsm]<=regis[0];
	
	end
SUM: begin
     regis[destination]<=regis[0]+regis[source];
	 
	 end
SB: begin
    regis[destination]<=regis[0]-regis[source];
	
	end
CM: begin
    if(regis[destination]>regis[source])begin flag_cmp<=3'b100; end
	else if(regis[destination]==regis[source])begin flag_cmp<=3'b010; end
	else if(regis[destination]<regis[source])begin flag_cmp<=3'b001; end	
	end
ANR: begin
     regis[destination]<=regis[0] & regis[source];
	 
	 end
ORR: begin
     regis[destination]<=regis[0] | regis[source];
	 
	 end
XRR: begin
     regis[destination]<=regis[0] ^ regis[source];
	 
	 end

SMI: begin 
     if(sign_am==1) begin regis[destination]<=regis[0]-immediate_am_use;end
     else if(sign_am==0) begin regis[destination]<=regis[0]+immediate_am_use;end
	 end
SBI: begin 
     if(sign_am==1) begin regis[destination]<=regis[0]+immediate_am_use; end
     else if(sign_am==0) begin regis[destination]<=regis[0]-immediate_am_use; end
	 end
CMI: begin
     if(sign_am==1) begin flag_cmp<=3'b100; end
	 else if(sign_am==0) begin
	                     if(regis[destination]>immediate_am_use)begin flag_cmp<=3'b100; end
						 else if(regis[destination]==immediate_am_use)begin flag_cmp<=3'b010;end
						 else if(regis[destination]<immediate_am_use)begin flag_cmp<=3'b001; end
						 end
	 end
ANI: begin regis[destination]<= regis[0] & immediate_am_logic;end
ORI: begin regis[destination]<= regis[0] | immediate_am_logic;end
XRI: begin regis[destination]<= regis[0] ^ immediate_am_logic;end
MR : begin regis[destination]<= regis[source];end
MI : begin regis[destination]<= immediate_am_logic;end
endcase
end
end
		  
endmodule