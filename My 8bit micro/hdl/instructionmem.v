module instruction_mem(machine_code,clk,rst,instruction_needed,prgm_cnt);

input [71:0] machine_code;
input clk,rst;
output reg [7:0]instruction_needed;
output reg [3:0] prgm_cnt;
reg  state;

reg [71:0] machine_code_temp,machine_code_temp1,machine_code_temp2,machine_code_temp3,machine_code_temp4,machine_code_temp5,machine_code_temp6,machine_code_temp7;

always @*
begin
machine_code_temp=machine_code;
end
always @(posedge clk or posedge rst)
begin
if(rst) 
  begin
 state<=0;
  prgm_cnt<=0;
  
  end
else
  begin

    case(state)
	
0: begin    instruction_needed<=machine_code_temp[71:64];
    

	prgm_cnt<=prgm_cnt+1;
	state<=1;
	end
	
1: begin
   machine_code_temp<=machine_code_temp<<8;
   state<=0;
   end
	
	
endcase

	

  end
end
endmodule