class environment;

//intance creation
generator gen;
driver driv;
monitor mon;
scoreboard sb;


//mailbox
mailbox gen2dri;
mailbox mon2sb;

//event for synchronization between generator and test
event gen_ended;

//virtual interface
virtual mem_intf v_if;

//constructor
function new(virtual mem_intf v_if);
this.v_if = v_if;

gen2dri = new();
mon2sb = new();

gen = new(gen2dri,gen_ended);
driv = new(v_if,gen2dri);
mon = new(v_if,mon2sb);
sb = new(mon2sb);
endfunction

task pre_test();
driv.reset();
endtask

task test();
fork
gen.main();
driv.DRIVER();
mon.main();
sb.main();
join_any
endtask

task post_test();
wait(gen_ended.triggered);
wait(gen.repeat_cnt == driv.no_trans);
wait(gen.repeat_cnt == sb.no_trans);
endtask

task run;
pre_test();
test();
post_test();

$finish;
endtask

endclass
