module top(machine_code,clk,rst,regis,flag_cmp,prgm_cnt);

input [71:0]machine_code;
input clk,rst;
output reg [2:0]flag_cmp;
output reg [7:0] regis[0:3];
output reg[3:0] prgm_cnt;

reg [7:0]instruction_needed;

instruction_mem I1(machine_code,clk,rst,instruction_needed,prgm_cnt);

my_micro M1(instruction_needed,clk,rst,regis,flag_cmp);





endmodule