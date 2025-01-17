class environment extends uvm_env;
  `uvm_component_utils(environment)
  
  scoreboard sb;
  agent agt;
  
  function new(string name = "environment",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = agent::type_id::create("agt",this);
    sb = scoreboard::type_id::create("sb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.ap.connect(sb.aimp);
  endfunction
  
endclass
    