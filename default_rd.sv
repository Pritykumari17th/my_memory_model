
program test(mem_intf intf);

class wr_trans extends transaction;

bit [1:0] count;


function void pre_randomize();
wr_en.rand_mode(0);
rd_en.rand_mode(0);
addr.rand_mode(0);

wr_en = 0;
rd_en = 1;
addr = count;
count++;
endfunction
endclass

//creating handle

environment env;
wr_trans w_tr;

initial begin

env = new(intf);
w_tr = new();

env.gen.repeat_cnt= 10;
env.gen.trans = w_tr;

env.run();

end
endprogram 
