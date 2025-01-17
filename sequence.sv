/*class write_sqnc extends uvm_sequence#(seq_item);
  
  `uvm_object_utils(write_sqnc)
  seq_item tr;
  
  function new(string name ="write_sqnc");
    super.new(name);
  endfunction
  
  task body();
    repeat(5) begin
       
      `uvm_do_with(tr,{tr.wen == 1;})
      $display("sequence : wen = %0d|| ren = %0d || addr = %0d || wdata = %0d||rdata = %0d",tr.wen,tr.ren,tr.addr,tr.wdata,tr.rdata);
    end
  endtask
endclass


///////////////////////////////////////////////////////////////////


class read_sqnc extends uvm_sequence#(seq_item);
  
  `uvm_object_utils(read_sqnc)
  seq_item tr;
  
  function new(string name ="read_sqnc");
    super.new(name);
  endfunction
  
  task body();
    repeat(5) begin
      
      `uvm_do_with(tr,{tr.ren == 1;})
      $display("sequence : wen = %0d|| ren = %0d || addr = %0d || wdata = %0d||rdata = %0d",tr.wen,tr.ren,tr.addr,tr.wdata,tr.rdata);
    end
  endtask
endclass*/



class sqnc extends uvm_sequence#(seq_item);
  `uvm_object_utils(sqnc)
  seq_item tr;
  
  function new(string name = "sqnc");
    super.new(name);
  endfunction
  
  task body();
    tr = seq_item::type_id::create("tr");
    repeat(5) begin
    start_item(tr);
      tr.randomize() with {wen == 1;ren == 0;};
    finish_item(tr);
    end
    
    repeat(5) begin
    start_item(tr);
      tr.randomize() with {ren == 1;wen == 0;};
    finish_item(tr);
    end
    
//     `uvm_do_with(tr,{tr.wen==1;})
//     `uvm_do_with(tr,{tr.ren==1;})
    
    $display("sequence : wen = %0d || ren = %0d || addr = %0d || wdata = %0d||rdata = %0d",tr.wen,tr.ren,tr.addr,tr.wdata,tr.rdata);
  endtask
  
endclass


































































































