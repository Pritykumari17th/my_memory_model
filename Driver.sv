`define DRIV_IF v_if.driver.dri_cb

class driver;

int no_trans;

virtual mem_intf v_if;
mailbox gen2dri;

function new(virtual mem_intf v_if, mailbox gen2dri);
this.v_if = v_if;
this.gen2dri = gen2dri;
endfunction

task reset;
wait(v_if.reset);
$display("Reset Started");
`DRIV_IF.rd_en <= 0;
`DRIV_IF.wr_en <= 0;
`DRIV_IF.addr <= 0;
`DRIV_IF.wdata <= 0;
wait(!v_if.reset);
$display("Reset Ended");

endtask

task DRIVER;
forever begin
transaction trans;

`DRIV_IF.wr_en <= 0;
`DRIV_IF.rd_en <= 0;
gen2dri.get(trans);
$display("Number of transaction = %0d ", no_trans);
//$display("-----------------");

@(posedge v_if.driver.clk);
`DRIV_IF.addr <= trans.addr;

if(trans.wr_en) begin
`DRIV_IF.wr_en <= trans.wr_en;
`DRIV_IF.wdata <= trans.wdata;
//$display("Addr = %0h, \t wr_en =%0h, \tWData = %0h", trans.addr,trans.wr_en, trans.wdata);
 $display("\tADDR = %0h \tWDATA = %0h",trans.addr,trans.wdata);
//$display("-----------------");
@(posedge v_if.driver.clk);
end

if(trans.rd_en) begin
`DRIV_IF.rd_en <= trans.rd_en;
@(posedge v_if.driver.clk);
`DRIV_IF.rd_en <= 0;
@(posedge v_if.driver.clk);
trans.rdata = `DRIV_IF.rdata;
//$display("Addr = %0h, trans.rd_en = %0h, DRIV_IF.rData = %0h",trans.addr,trans.rd_en, `DRIV_IF.rdata);
$display("\tADDR = %0h \tRDATA = %0h",trans.addr,`DRIV_IF.rdata);
$display("-----------------");
end
no_trans++;
end
endtask

/*task main;
    forever begin
      fork
        //Thread-1: Waiting for reset
        begin
          wait(v_if.reset);
        end
        //Thread-2: Calling drive task
        begin
          forever
            DRIVER();
        end
      join_any
      wait fork;
    end
  endtask*/
        
endclass


