`include "transaction.sv"
`include "generator.sv"
`include "Driver.sv"
`include "interface.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

//test plans
`include "random_test.sv"
//`include "wr_test.sv"
//`include "default_rd.sv"


module tbench_top;
bit clk;
bit reset;


always #10 clk = ~clk;

//creatinng instance of interface, inorder to connect DUT and testcase
mem_intf intf(clk,reset);

test t1(intf);

memory tb(.clk(intf.clk),.rd_en(intf.rd_en),.wr_en(intf.wr_en),.wdata(intf.wdata),.rdata(intf.rdata),.addr(intf.addr),.reset(intf.reset));

initial begin
reset = 1;
#10 reset = 0;


//Enable the below line to assert reset in middle of the simulation and also uncomment the `include "wr_test.sv" file for the operation.
#150 reset = 1;
#10 reset = 0;


end
endmodule


