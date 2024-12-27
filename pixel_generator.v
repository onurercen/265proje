`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.12.2024 18:08:20
// Design Name: 
// Module Name: pixel_generator
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


module pixel_generator(
    input wire clk,
    input wire [9:0] x,
    input wire [9:0] y,
    input wire visible,
    input wire [4:0] snake_x,
    input wire [4:0] snake_y,
    input wire [4:0] yem_x,
    input wire [4:0] yem_y,
    input wire [5:0] snake_length,
    input enable,
    input game_over,
    output reg [11:0] rgb
   
);
//    integer i;

    always @(*) begin
        if (!game_over) begin
            if (!visible) begin
                rgb = 12'H000; // Siyah
            end else if ((x / 20 == yem_x) && (y / 20 == yem_y)) begin
                rgb = 12'HF00; // Kýrmýzý Yem
            end else begin
                rgb = 12'H000; // Varsayýlan Siyah
                if ((x / 20 == snake_x) && (y / 20 == snake_y) && enable) begin
                       rgb = 12'H0F0; // Yeþil Yýlan
                end
    //            for (i = 0; i < snake_length; i = i + 1) begin
    //                if ((x / 20 == snake_x) && (y / 20 == snake_y)) begin
    //                    {r, g, b} = 8'b000_111_00; // Yeþil Yýlan
    //                end
    //            end
            end
        end
        else rgb = 12'HFFF;
    end
endmodule