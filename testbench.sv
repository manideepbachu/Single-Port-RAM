// Code your testbench here
// or browse Examples
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "interface.sv"
`include "package.sv"
`include "test.sv"
module tb_top;
  
  bit clk,rst;
  
  inf vif(clk,rst);
  always #5 clk = ~clk;
  memory dut(.clk(vif.clk),.rst(vif.rst),.addr(vif.addr),.wen(vif.wen),.ren(vif.ren),.wdata(vif.wdata),.rdata(vif.rdata));
  
  initial begin
    uvm_config_db#(virtual inf)::set(null,"*","vif",vif);
  end
  
  initial begin
    rst = 1;
    
    #5 rst = 0;
    
  end
  
  initial begin
    run_test("test");
  end
  
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
    
  
endmodule
  
  