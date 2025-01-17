class seq_item extends uvm_sequence_item;
  
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(addr,UVM_ALL_ON)
  `uvm_field_int(wen,UVM_ALL_ON)
  `uvm_field_int(wdata,UVM_ALL_ON)
  `uvm_field_int(rdata,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "seq_item");
    super.new(name);
  endfunction
  
  rand bit[3:0] addr;
  rand bit wen,ren;
  rand bit[7:0] wdata;
  bit [7:0] rdata;
  
  constraint addr_en{addr inside {0,1,2,3,4,5};}
  constraint wen_ren{wen != ren;}
  constraint wen_c{wen dist {0 :/ 4 , 1:/ 6};}
  constraint ren_c{ren dist {0 :/ 6 , 1:/ 4};}
  
endclass