class scoreboard;
mailbox mon2sb;


int no_trans;
bit [7:0] mem[10];


function new(mailbox mon2sb);
this.mon2sb = mon2sb;
foreach(mem[i]) mem[i] = 8'hFF;
endfunction



task main;
transaction trans;

forever begin
#100;//scoreboard is asynchronus, it just compares the expected and actual value.(it doesn't need to follow the design clk i.e. we cannot use @posedge clk).
mon2sb.get(trans);
if(trans.rd_en)
begin
if(mem[trans.addr] == trans.rdata) begin 
$display("[SCB - PASS] Addr = %0h, \n Data :: Expected = %0h  Actual = %0h", trans.addr,mem[trans.addr],trans.rdata);
end
else
if(mem[trans.addr] != trans.rdata) 
$error("[SCB - FAIL] Addr = %0h, \n Data :: Expected = %0h  Actual = %0h", trans.addr,mem[trans.addr],trans.rdata);
end
else
if(trans.wr_en)
mem[trans.addr] = trans.wdata;
no_trans++;
end

endtask

endclass
