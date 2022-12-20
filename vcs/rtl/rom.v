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

`include "defines.v"


module rom(

    input                       clk,

    input                       ceb,        // write enable
    input                       web,
    input       [`MemBus]       bweb,       // bit-write enable
    input       [`MemAddrBus]   addr_i,     // addr
    input       [`MemBus]       data_i,

    output  reg [`MemBus]       data_o      // read data
);

 reg[`MemBus] rom[0:`RomNum - 1];

generate
    genvar i;
    for ( i = 0; i < 64; i = i + 1) begin: bweb_write
        always @ (posedge clk) begin
            if (ceb == 1'b0 && web == 1'b0) begin
                case (bweb[i])
                    1'b0: rom[addr_i][i]  <=  data_i[i];
                    default : /* default */;
                endcase
            end
        end
    end
endgenerate

always @(posedge clk) begin
    if (ceb == 1'b0) begin
        data_o  <=  rom[addr_i];
    end
end

//==============================================================================
// write: Write byte into memory
//==============================================================================
task write;
    input [31:0]    addr;
    input [31:0]    data;
    begin
    case (addr[2:0])
        3'b000:rom[addr/8][7:0]     =   data;
        3'b001:rom[addr/8][15:8]    =   data;
        3'b010:rom[addr/8][23:16]   =   data;
        3'b011:rom[addr/8][31:24]   =   data;
        3'b100:rom[addr/8][39:32]   =   data;
        3'b101:rom[addr/8][47:40]   =   data;
        3'b110:rom[addr/8][55:48]   =   data;
        3'b111:rom[addr/8][63:56]   =   data;
    endcase
end
endtask

endmodule
