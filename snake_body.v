`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2024 14:18:36
// Design Name: 
// Module Name: snake_body
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


module snake_body(
    input wire clk,
    input [4:0] snake_head_x,
    input [4:0] snake_head_y,
    input [4:0] snake_x_before,
    input [4:0] snake_y_before,
    input enable,
    output reg [4:0] snake_x, // Yýlanýn X koordinatlarý
    output reg [4:0] snake_y, // Yýlanýn Y koordinatlarý
    output reg game_over
    );
    
    always @(posedge clk) begin
        if(enable) begin
            snake_x <= snake_x_before;
            snake_y <= snake_y_before;
            if(snake_head_x == snake_x_before && snake_head_y == snake_y_before) game_over <= 1;
            else game_over <= 0;
        end
    end
    
    
endmodule
