program test(mem_intf intf);

class wr_trans extends transaction;

bit [1:0] count;
bit [1:0]  cnt;

function void pre_randomize();
wr_en.rand_mode(0);
rd_en.rand_mode(0);
addr.rand_mode(0);

//foreach cnt[i] begin
if(cnt % 2 == 0) begin
wr_en = 1;
rd_en = 0;
addr = count;
end
else begin
wr_en = 0;
rd_en = 1;
addr = count;
count++;
end
cnt++;

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
