class monitor extends uvm_monitor#(seq_item);
  `uvm_component_utils(monitor)
  
  seq_item mon_seq;
  virtual inf vif;
  uvm_analysis_port#(seq_item) ap;
  
  function new(string name = "monitor",uvm_component parent = null);
    super.new(name,parent);
    ap = new("ap",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_seq = seq_item::type_id::create("mon_seq",this);
    if(!uvm_config_db#(virtual inf)::get(this," ","vif",vif))
      `uvm_fatal(get_type_name,"no interface");
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      wait(vif.wen || vif.ren);
      @(negedge vif.clk);
      mon_seq.addr = vif.addr;
      
      if(vif.wen) begin
        mon_seq.wen = vif.wen;
        mon_seq.wdata = vif.wdata;
      end
      
      else if(vif.ren) begin
      mon_seq.ren = vif.ren;
      mon_seq.rdata = vif.rdata;
      end
      
      $display("monitor : wen = %0d ||ren = %0d || addr = %0d || wdata = %0d||rdata = %0d",mon_seq.wen,mon_seq.ren,mon_seq.addr,mon_seq.wdata,mon_seq.rdata);
      $display("_______________________________");
      
      ap.write(mon_seq);
      
    end
  endtask
  
endclass
    
  







































































/*task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk)
      wait(vif.wen || vif.ren);
      mon_seq.addr = vif.addr;
      if(vif.wen) begin
        mon_seq.wen = vif.wen;
        mon_seq.wdata = vif.wdata;
        mon_seq.ren = 0;
        $display("monitor : wen = %0d || ren = %0d || addr = %0d || wdata = %0d||rdata = %0d",mon_seq.wen,mon_seq.ren,mon_seq.addr,mon_seq.wdata,mon_seq.rdata);
      end
      else if(vif.ren) begin
        mon_seq.ren = vif.ren;
        mon_seq.wen = 0;
        mon_seq.rdata = vif.rdata;
        $display("monitor : wen = %0d || ren = %0d || addr = %0d || wdata = %0d||rdata = %0d",mon_seq.wen,mon_seq.ren,mon_seq.addr,mon_seq.wdata,mon_seq.rdata);
      end
      ap.write(mon_seq);
    end
  endtask*/