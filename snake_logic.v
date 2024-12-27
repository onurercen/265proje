`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.12.2024 18:08:20
// Design Name: 
// Module Name: snake_logic
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


module snake_logic(
    input wire clk,
    input wire [3:0] direction,  // Y�lan�n hareket y�n�
    input wire [4:0] snake_x_before,
    input wire [4:0] snake_y_before,
    input [4:0] yem_x_before,
    input [4:0] yem_y_before,
    output reg [4:0] snake_x, // Y�lan�n X koordinatlar�
    output reg [4:0] snake_y, // Y�lan�n Y koordinatlar�
    output reg [4:0] yem_x,         // Yemin X koordinat�
    output reg [4:0] yem_y,         // Yemin Y koordinat�
    output reg [5:0] snake_length  // Y�lan�n uzunlu�u
);
    reg game_over = 0; // Oyun durumu (0 = devam, 1 = bitti)

//        integer i;

    always @(posedge clk) begin
        if (game_over == 0) begin
            // G�vdeyi kayd�r
//            for (i = snake_length; i > 0; i = i - 1) begin
//                snake_x[i] <= snake_x[i - 1];
//                snake_y[i] <= snake_y[i - 1];
//            end

            // Yeni kafa pozisyonunu belirle
            case (direction)
                0: snake_y <= snake_y_before - 1; // Yukar�
                4: snake_x <= snake_x_before + 1; // Sa�
                8: snake_y <= snake_y_before + 1; // A�a��
                2: snake_x <= snake_x_before - 1; // Sol
            endcase

            // Yem yeme kontrol�
            if (snake_x == yem_x_before && snake_y == yem_y_before) begin
                snake_length <= snake_length + 1; // Y�lan� uzat
                yem_x <= $random % 32; // Yeni yem X koordinat�
                yem_y <= $random % 24; // Yeni yem Y koordinat�
            end
            else begin
                yem_x <= yem_x_before;
                yem_y <= yem_y_before;
            end

            // Duvara �arpma kontrol�
            if (snake_x >= 32 || snake_y >= 24) begin
                game_over <= 1; // Oyun bitti
            end

            // Kendine �arpma kontrol�
//            for (i = 1; i < snake_length; i = i + 1) begin
//                if (snake_x[0] == snake_x[i] && snake_y[0] == snake_y[i]) begin
//                    game_over <= 1; // Oyun bitti
//                end
//            end
        end
    end
endmodule