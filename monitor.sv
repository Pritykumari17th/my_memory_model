`define MON_IF v_if.monitor.mon_cb
class monitor;
virtual mem_intf v_if;

mailbox mon2sb;

function new(virtual mem_intf v_if,mailbox mon2sb);
this.v_if = v_if;
this.mon2sb = mon2sb;
endfunction

task main;
forever begin
transaction trans;

trans = new();

@(posedge v_if.monitor.clk);
wait(`MON_IF.rd_en || `MON_IF.wr_en);
trans.addr = `MON_IF.addr;
trans.wr_en = `MON_IF.wr_en;
trans.wdata = `MON_IF.wdata;

if(`MON_IF.rd_en) begin
trans.rd_en = `MON_IF.rd_en;

repeat(2)begin
@(posedge v_if.monitor.clk);
end

trans.rdata = `MON_IF.rdata;
end
mon2sb.put(trans);
end
endtask
endclass
