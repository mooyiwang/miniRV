`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/07/05 20:12:43
// Design Name: 
// Module Name: digit_driver
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


module digit_driver(
    input wire          clk,
    input wire          rst_n,
    input wire [31:0]   adr,
    input wire          wE,
    input wire [31:0]   wD,
    output reg [7:0]   led_en,
    output wire [7:0]   digit_led_cx_o
    );
    

reg  [31:0] cnt;
wire [31:0] cnt_end;
reg  [6: 0] led_cx;
reg  [3: 0] digit;
reg  [31:0] cal_result;

assign cnt_end =  32'd49999;
assign digit_led_cx_o = {led_cx, 1'b1};


always @(posedge clk or negedge rst_n) begin
    if(~rst_n) cnt <= 32'd0;
    else if(cnt == cnt_end) cnt <= 32'd0;
    else cnt <= cnt + 32'd1;
end

    
always @( posedge clk or negedge rst_n ) begin
   if(~rst_n) led_en <= 8'hfe;
   else if(cnt == cnt_end ) led_en <= {led_en[6:0],led_en[7]};     
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) cal_result <= 32'b0;
    else if(wE && adr==32'hfffff000) cal_result <= wD;
end

always @(posedge clk or negedge rst_n) begin
     if(~rst_n) digit <= 4'h0;
     else if(cnt == cnt_end) begin
             case({led_en[6:0],led_en[7]})
             8'hfe: digit <= cal_result[3:0];
             8'hfd: digit <= cal_result[7:4];
             8'hfb: digit <= cal_result[11:8];
             8'hf7: digit <= cal_result[15:12];
             8'hef: digit <= cal_result[19:16];
             8'hdf: digit <= cal_result[23:20];
             8'hbf: digit <= cal_result[27:24];
             8'h7f: digit <= cal_result[31:28];
             endcase
     end
 end

 always @(*) begin
     if(~rst_n) led_cx = 7'b111_1111;
     else begin
         case(digit)
         4'h0:led_cx = 7'b000_0001;
         4'h1:led_cx = 7'b100_1111;
         4'h2:led_cx = 7'b001_0010;
         4'h3:led_cx = 7'b000_0110;
         4'h4:led_cx = 7'b100_1100;
         4'h5:led_cx = 7'b010_0100;
         4'h6:led_cx = 7'b010_0000;
         4'h7:led_cx = 7'b000_1111;
         4'h8:led_cx = 7'b000_0000;
         4'h9:led_cx = 7'b000_1100;
         4'ha:led_cx = 7'b000_1000;
         4'hb:led_cx = 7'b110_0000;
         4'hc:led_cx = 7'b111_0010;
         4'hd:led_cx = 7'b100_0010;
         4'he:led_cx = 7'b011_0000;
         4'hf:led_cx = 7'b011_1000;
         endcase        
     end
 end
endmodule
