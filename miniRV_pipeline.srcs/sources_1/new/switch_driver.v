`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 20:02:23
// Design Name: 
// Module Name: switch_driver
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module switch_driver(
    input wire          clk_i,
    input wire [23:0]   switch_i,
    input wire [31:0]   adr,
    output reg [31:0]   rD
    );

always@(*)begin
    if(adr==32'hfffff070) rD = {8'b0, switch_i};
end
    
endmodule
