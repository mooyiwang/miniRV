`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 20:02:23
// Design Name: 
// Module Name: LED_driver
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


module LED_driver(
    input wire          clk_i,
    input wire          rst_n,
    input wire [31:0]   adr,
    input wire          wE,
    input wire [31:0]   wD,
    output reg [23:0]  led_o
    );
    
always@(posedge clk_i or negedge rst_n) begin
    if(~rst_n) led_o <= 24'b0;
    else if(wE && adr==32'hfffff060) led_o <= wD[23:0];
end
    
    
endmodule
