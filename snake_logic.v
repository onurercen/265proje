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
    input wire [3:0] direction,  // Yılanın hareket yönü
    input wire [4:0] snake_x_before, // Yılanın X koordinatları
    input wire [4:0] snake_y_before, // Yılanın Y koordinatları
    input [4:0] yem_x_before,       // Yemin X koordinatı
    input [4:0] yem_y_before,       // Yemin Y koordinatı
    output reg [4:0] snake_x, // güncellenmiş X koordinatları
    output reg [4:0] snake_y, // güncellenmiş Y koordinatları
    output reg [4:0] yem_x,         // güncellenmiş X koordinatı
    output reg [4:0] yem_y,         // güncellenmiş Y koordinatı
    output reg [5:0] snake_length  // Yılanın uzunluğu
);
    // bunu kullanmıyoruz.
    reg game_over = 0; // Oyun durumu (0 = devam, 1 = bitti)
                        

    always @(posedge clk) begin
        if (game_over == 0) begin

            // Yeni kafa pozisyonunu belirle
            case (direction)
                4'b0001: snake_y <= snake_y_before - 1; // Yukarı 
                4'b0100: snake_x <= snake_x_before + 1; // Sağ    
                4'b1000: snake_y <= snake_y_before + 1; // Aşağı
                4'b0010: snake_x <= snake_x_before - 1; // Sol
            endcase

            // Yem yeme kontrolü
            if (snake_x == yem_x_before && snake_y == yem_y_before) begin
                snake_length <= snake_length + 1; // Yılanı uzat
                yem_x <= $random % 32; // Yeni yem X koordinatı
                yem_y <= $random % 24; // Yeni yem Y koordinatı
            end
            else begin
                yem_x <= yem_x_before;
                yem_y <= yem_y_before;
            end

            // oyunda duvar olsun mu
            // Duvara çarpma kontrolü
            if (snake_x >= 32 || snake_y >= 24) begin
                game_over <= 1; // Oyun bitti
            end
        end
    end
endmodule
