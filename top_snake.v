`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.12.2024 18:08:20
// Design Name: 
// Module Name: top_snake
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


module top_snake(
    input clk_100MHz,       // from Basys 3
    input reset,            // btn
    input [3:0] direction,  
    output hsync,           // to VGA port
    output vsync,           // to VGA port
    output [11:0] rgb       // to DAC, to VGA port
    );
    
    //modülleri bağlayan kablolar
    wire w_reset, w_vid_on, w_p_tick;
    wire [9:0] w_x, w_y;
    
    reg [11:0] rgb_reg;
    wire [11:0] rgb_next;
    
    //yilanin her bir koordinati tutmak için array
    reg [5:0] snake_x_reg [63:0];
    reg [5:0] snake_y_reg [63:0];
    wire [5:0] snake_x [63:0];
    wire [5:0] snake_y [63:0];
    
    // yilanin baslangic konumu
    initial begin
        snake_x_reg[0] = 16;
        snake_y_reg[0] = 10;
    end
    
    // oyunu oynatan bazı degerler
    wire [5:0] snake_length;
    reg [5:0] snake_length_reg;
    
    // yemi reg olarak mı tutsak?
    wire[4:0] yem_x;       // Yemin X koordinatı
    wire[4:0] yem_y;        // Yemin Y koordinatı
    wire game_over;     
    
    vga_controller vga(.clk_100MHz(clk_100MHz), .reset(w_reset), .video_on(w_vid_on),
                       .hsync(hsync), .vsync(vsync), .p_tick(w_p_tick), .x(w_x), .y(w_y));
    snake_logic logic (
                    .clk(w_p_tick),
                    .direction(direction),
                    .snake_x(snake_x[0]),
                    .snake_y(snake_y[0]),
                    .yem_x(yem_x),
                    .yem_y(yem_y),
                    .snake_length(snake_length)
    );
     
                      
     genvar i;
     generate 
        
        for(i = 1; i < 64; i = i + 1) begin
            //yilanın uzunluğuna göre array üstünde işlem yapmamız gereken yerleri belirlemek için
            wire enable = (i < snake_length_reg);   
            
                snake_body body (
                    .clk(w_p_tick),     // 25 MHz
                    .snake_head_x(snake_x_reg[0]),
                    .snake_head_y(snake_y_reg[0]),
                    .snake_x_before(snake_x_reg[i-1]),  // output olarak verilecek
                    .snake_y_before(snake_y_reg[i-1]),  // output olarak verilecek
                    .enable(enable),
                    .snake_x(snake_x[i]), // kendinden bi öncekinin konumuna geliyor
                    .snake_y(snake_y[i]), // kendinden bi öncekinin konumuna geliyor
                    .game_over(game_over)   //headin koordinatlarini alıp üst üste gelmedi mi kontrol edecek
                );
                                   
                pixel_generator pixel (
                    .clk(w_p_tick),     // 25MHZ
                    .x(w_x),    
                    .y(w_y),
                    .visible(w_vid_on),
                    .snake_x(snake_x_reg[i - 1]),
                    .snake_y(snake_y_reg[i - 1]),
                    .yem_x(yem_x),  
                    .yem_y(yem_y),
                    .rgb(rgb_next),
                    .enable(enable),
                    .game_over(game_over) //game over olunca bembeyaz yapıyor şimdilik
                );
        end
      
    endgenerate
                 
    integer j;
    
    always @(posedge clk_100MHz) begin
        if(w_p_tick) begin
            rgb_reg <= rgb_next;
            snake_length_reg <= snake_length;
            for (j = 0; j < 64; j = j +1) begin
                snake_x_reg[i] <= snake_x[i];
                snake_y_reg[i] <= snake_y[i];
            end
        end
    end
    
    assign rgb = rgb_reg;
endmodule
