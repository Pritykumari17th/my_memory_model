

program test(mem_intf intf);

environment env;

initial begin

env = new(intf);

env.gen.repeat_cnt = 20;

env.run();
end
endprogram
