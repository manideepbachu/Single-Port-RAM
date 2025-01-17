class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  driver drv;
  monitor mon;
  sequencer sqcr;
  
  function new(string name = "agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = driver::type_id::create("drv",this);
    mon = monitor::type_id::create("mon",this);
    sqcr = sequencer::type_id::create("sqcr",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sqcr.seq_item_export);
  endfunction
  
endclass

                                  