class driver extends uvm_driver#(seq_item);
  `uvm_component_utils(driver)
  
  virtual inf vif;
  
  function new(string name = "driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual inf)::get(this," ","vif",vif))
      `uvm_fatal(get_type_name," no interface");
  endfunction
  
  task reset_phase(uvm_phase phase);
    wait(vif.rst);
    vif.addr  = 0;
    vif.wen = 0;
    vif.ren = 0;
    vif.wdata = 0;
    vif.rdata = 0;
    wait(!vif.rst);
  endtask
  
  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();
      seq_item_port.item_done(req);
    end
  endtask
  

  
  /*task drive();
     @(posedge vif.clk);
    vif.addr <= req.addr;
    
    if(vif.wen) begin
      vif.wen <= req.wen;
      vif.wdata <= req.wdata;
    end
    
    else if(vif.ren) begin
      vif.ren <= req.ren;
    end
    
    
    //@(posedge vif.clk);
    //vif.wen <= 1'b0;
    //@(posedge vif.clk);
    

    
    $display("driver : wen = %0d||ren = %0d || addr = %0d || wdata = %0d",vif.wen,vif.ren,vif.addr,vif.wdata);
  endtask*/
  
  task drive();
    @(posedge vif.clk);
    vif.addr <= req.addr;
    vif.wen <= req.wen;
    vif.ren = req.ren;
    vif.wdata <= req.wdata;
    
    // @(posedge vif.clk);
    
    $display("driver : wen = %0d||ren = %0d || addr = %0d || wdata = %0d",vif.wen,vif.ren,vif.addr,vif.wdata);
  endtask
  
  
endclass









































/*task drive();
    wait(vif.rst)
    @(posedge vif.clk)begin
      vif.addr <= req.addr;
      if(req.wen) begin
        vif.wen <= req.wen;
        vif.wdata <= req.wdata;
        $display("driver : wen = %0d || ren = %0d || addr = %0d || wdata = %0d||rdata = %0d",vif.wen,vif.ren,vif.addr,vif.wdata,vif.rdata);
      end
      
      else if(req.ren)begin
        vif.ren <= vif.ren;
        @(posedge vif.clk);
        req.rdata = vif.rdata;
        $display("driver : wen = %0d || ren = %0d || addr = %0d || wdata = %0d||rdata = %0d",vif.wen,vif.ren,vif.addr,vif.wdata,vif.rdata);
      end
      
      @(posedge vif.clk);
    vif.wen <= 1'b0;
    vif.ren <= 1'b0;
    end
  endtask*/
  
    