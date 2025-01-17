class test extends uvm_test;
  `uvm_component_utils(test)
  
  environment env;
  sqnc sqc1;
//   write_sqnc w_sqc1;
//   read_sqnc r_sqc1;
  
  function new(string name = "test",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env",this);
    sqc1 = sqnc::type_id::create("sqc1",this);
//     w_sqc1 = write_sqnc::type_id::create("w_sqc1",this);
//     r_sqc1 = read_sqnc::type_id::create("r_sqc1",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
//     begin
//       w_sqc1.start(env.agt.sqcr);
//       r_sqc1.start(env.agt.sqcr);
//     end
    sqc1.start(env.agt.sqcr);
    phase.drop_objection(this);
    phase.phase_done.set_drain_time(this,100);
  endtask
  
endclass