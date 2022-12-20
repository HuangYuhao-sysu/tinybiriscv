 /*                                                                      
 Copyright 2020 Blue Liang, liangkangnan@163.com
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
 Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */


// spi master模块
module spi(

    input wire clk,
    input wire rst_n,

    input wire[31:0] data_i,
    input wire[31:0] addr_i,
    input wire we_i,

    output reg[31:0] data_o,

    output reg spi_mosi,             // spi控制器输出�?�spi设备输入信号
    input wire spi_miso,             // spi控制器输入�?�spi设备输出信号
    output wire spi_ss,              // spi设备片�??
    output reg spi_clk               // spi设备时钟，最大频率为输入clk的一�?

    );


    localparam SPI_CTRL   = 4'h0;    // spi_ctrl寄存器地�?偏移
    localparam SPI_DATA   = 4'h4;    // spi_data寄存器地�?偏移
    localparam SPI_STATUS = 4'h8;    // spi_status寄存器地�?偏移

    // spi控制寄存�?
    // addr: 0x00
    // [0]: 1: enable, 0: disable
    // [1]: CPOL
    // [2]: CPHA
    // [3]: select slave, 1: select, 0: deselect
    // [15:8]: clk div
    reg[31:0] spi_ctrl;
    // spi数据寄存�?
    // addr: 0x04
    // [7:0] cmd or inout data
    reg[31:0] spi_data;
    // spi状�?�寄存器
    // addr: 0x08
    // [0]: 1: busy, 0: idle
    reg[31:0] spi_status;

    reg[8:0] clk_cnt;               // 分频计数
    reg en;                         // 使能，开始传输信号，传输期间�?直有�?
    reg[4:0] spi_clk_edge_cnt;      // spi clk时钟沿的个数
    reg spi_clk_edge_level;         // spi clk沿电�?
    reg[7:0] rdata;                 // 从spi设备读回来的数据
    reg done;                       // 传输完成信号
    reg[3:0] bit_index;             // 数据bit索引
    wire[8:0] div_cnt;


    assign spi_ss = ~spi_ctrl[3];   // SPI设备片�?�信�?

    assign div_cnt = spi_ctrl[15:8];// 0: 2分频�?1�?4分频�?2�?8分频�?3�?16分频�?4�?32分频，以此类�?


    // 产生使能信号
    // 传输期间�?直有�?
    always @ (posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            en <= 1'b0;
        end else begin
            if (spi_ctrl[0] == 1'b1) begin
                en <= 1'b1;
            end else if (done == 1'b1) begin
                en <= 1'b0;
            end else begin
                en <= en;
            end
        end
    end

    // 对输入时钟进行计�?
    always @ (posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            clk_cnt <= 9'h0;
        end else if (en == 1'b1) begin
            if (clk_cnt == div_cnt) begin
                clk_cnt <= 9'h0;
            end else begin
                clk_cnt <= clk_cnt + 1'b1;
            end
        end else begin
            clk_cnt <= 9'h0;
        end
    end

    // 对spi clk沿进行计�?
    // 每当计数到分频�?�时产生�?个上升沿脉冲
    always @ (posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            spi_clk_edge_cnt <= 5'h0;
            spi_clk_edge_level <= 1'b0;
        end else if (en == 1'b1) begin
            // 计数达到分频�?
            if (clk_cnt == div_cnt) begin
                if (spi_clk_edge_cnt == 5'd17) begin
                    spi_clk_edge_cnt <= 5'h0;
                    spi_clk_edge_level <= 1'b0;
                end else begin
                    spi_clk_edge_cnt <= spi_clk_edge_cnt + 1'b1;
                    spi_clk_edge_level <= 1'b1;
                end
            end else begin
                spi_clk_edge_level <= 1'b0;
            end
        end else begin
            spi_clk_edge_cnt <= 5'h0;
            spi_clk_edge_level <= 1'b0;
        end
    end

    // bit序列
    always @ (posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            spi_clk <= 1'b0;
            rdata <= 8'h0;
            spi_mosi <= 1'b0;
            bit_index <= 4'h0;
        end else begin
            if (en) begin
                if (spi_clk_edge_level == 1'b1) begin
                    case (spi_clk_edge_cnt)
                        // 第奇数个时钟�?
                        1, 3, 5, 7, 9, 11, 13, 15: begin
                            spi_clk <= ~spi_clk;
                            if (spi_ctrl[2] == 1'b1) begin
                                spi_mosi <= spi_data[bit_index];   // 送出1bit数据
                                bit_index <= bit_index - 1'b1;
                            end else begin
                                rdata <= {rdata[6:0], spi_miso};   // �?1bit数据
                            end
                        end
                        // 第偶数个时钟�?
                        2, 4, 6, 8, 10, 12, 14, 16: begin
                            spi_clk <= ~spi_clk;
                            if (spi_ctrl[2] == 1'b1) begin
                                rdata <= {rdata[6:0], spi_miso};   // �?1bit数据
                            end else begin
                                spi_mosi <= spi_data[bit_index];   // 送出1bit数据
                                bit_index <= bit_index - 1'b1;
                            end
                        end
                        17: begin
                            spi_clk <= spi_ctrl[1];
                        end
                    endcase
                end
            end else begin
                // 初始状�??
                spi_clk <= spi_ctrl[1];
                if (spi_ctrl[2] == 1'b0) begin
                    spi_mosi <= spi_data[7];           // 送出�?高位数据
                    bit_index <= 4'h6;
                end else begin
                    bit_index <= 4'h7;
                end
            end
        end
    end

    // 产生结束(完成)信号
    always @ (posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            done <= 1'b0;
        end else begin
            if (en && spi_clk_edge_cnt == 5'd17) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // write reg
    always @ (posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            spi_ctrl <= 32'h0;
            spi_data <= 32'h0;
            spi_status <= 32'h0;
        end else begin
            spi_status[0] <= en;
            if (we_i == 1'b1) begin
                case (addr_i[3:0])
                    SPI_CTRL: begin
                        spi_ctrl <= data_i;
                    end
                    SPI_DATA: begin
                        spi_data <= data_i;
                    end
                    default: begin

                    end
                endcase
            end else begin
                spi_ctrl[0] <= 1'b0;
                // 发�?�完成后更新数据寄存�?
                if (done == 1'b1) begin
                    spi_data <= {24'h0, rdata};
                end
            end
        end
    end

    // read reg
    always @ (*) begin
        case (addr_i[3:0])
            SPI_CTRL: begin
                data_o = spi_ctrl;
            end
            SPI_DATA: begin
                data_o = spi_data;
            end
            SPI_STATUS: begin
                data_o = spi_status;
            end
            default: begin
                data_o = 32'h0;
            end
        endcase
    end

endmodule
