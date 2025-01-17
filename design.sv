// Code your design here
module memory
  #( parameter ADDR_WIDTH = 4,
     parameter DATA_WIDTH = 8 ) (
    input clk,
    input rst,
    
    //control signals
    input [ADDR_WIDTH-1:0]  addr,
    input                   wen,
    input                   ren,
    
    //data signals
    input  [DATA_WIDTH-1:0] wdata,
    output [DATA_WIDTH-1:0] rdata
  ); 
  
  reg [DATA_WIDTH-1:0] rdata;
  
  //Memory
  reg [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH];

  //rst 
  always @(posedge rst) 
    for(int i=0;i<2**ADDR_WIDTH;i++) mem[i]=8'hFF;
   
  // Write data to Memory
  always @(posedge clk) 
    if (wen)    mem[addr] <= wdata;

  // Read data from memory
  always @(posedge clk)
    if (ren) rdata <= mem[addr];

endmodule