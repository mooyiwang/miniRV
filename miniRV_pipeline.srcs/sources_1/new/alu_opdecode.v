`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/28 17:25:41
// Design Name: 
// Module Name: alu_opdecode
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


module alu_opdecode(
    input wire [2:0]    alu_op,
    output reg [6:0]    decoded
    );
    
always@(*)begin 
    case(alu_op)
        3'b000: decoded = 7'b0000000;
        3'b001: decoded = 7'b1000000;
        3'b010: decoded = 7'b0000001;
        3'b011: decoded = 7'b0010001;
        3'b100: decoded = 7'b0100001;
        3'b101: decoded = 7'b0000010;
        3'b110: decoded = 7'b0000110;
        3'b111: decoded = 7'b0001010;
    endcase
end
endmodule
