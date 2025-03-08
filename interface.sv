interface mem_intf(input logic clk , reset);

logic [1:0] addr;
logic wr_en;
logic rd_en;
logic [7:0] wdata;
logic [7:0] rdata;



//driver clocking block
clocking dri_cb @(posedge clk);
default input #1 output#1;
//driver block drives the signals , i.e. it is mandotory to initialize variable as input/output
output addr;
output wr_en;
output rd_en;
output wdata;
input rdata;
endclocking


//monitor clocking block
clocking mon_cb @(posedge clk);
default input #1 output#1;
//All signals are input because it only observe/monitor the signals
input addr;
input wr_en;
input rd_en;
input wdata;
input rdata;
endclocking



modport driver(clocking dri_cb,input clk,reset);

modport monitor(clocking mon_cb,input clk,reset);

endinterface

