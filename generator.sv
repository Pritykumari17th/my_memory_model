
class generator;

rand transaction trans,tr;
mailbox gen2dri;
int repeat_cnt;
event ended;

function new(mailbox gen2dri,event ended);
//function new(mailbox gen2dri);
this.gen2dri = gen2dri;
this.ended = ended;
trans = new();
endfunction

task main();
repeat (repeat_cnt) begin

if(!trans.randomize()) $fatal("gen : trans randomization failed !");
tr = trans.do_copy();
gen2dri.put(tr);
//gen2dri.put(trans);
end
-> ended;
endtask

endclass
