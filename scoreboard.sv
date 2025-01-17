class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp #(seq_item,scoreboard) aimp;
  seq_item sb_seq;
  int q[$];
  
  function new(string name = "scoreboard",uvm_component parent = null);
    super.new(name,parent);
    aimp = new("aimp",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_seq = seq_item::type_id::create("sb_seq",this);
  endfunction
  
  function void write(seq_item c_seq);
    
    bit[7:0] outdata;
    sb_seq = c_seq;
    if(sb_seq.wen == 1)begin
      q.push_back(sb_seq.wdata);
      $display("q = %0p",q);
    end
    
    else if(!sb_seq.wen)begin
      outdata = q.pop_front();
      
      $display("outdata = %0d",outdata);
      $display("data_out = %0d",sb_seq.rdata);
      
      if(outdata == sb_seq.rdata)begin
        `uvm_info(get_type_name(),"----------passed-------------",UVM_LOW);
      end
      
      else
        `uvm_info(get_type_name(),"----------failed-------------",UVM_LOW);
    end
  endfunction
  
endclass

