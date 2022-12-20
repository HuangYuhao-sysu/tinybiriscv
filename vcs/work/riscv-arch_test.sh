#!/bin/bash

#
# Run all riscv arch test and output ram file to result director
#

./vcs.sh
wait

sed -i '100s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '101s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '163s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '164s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '101s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '102s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '164s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '165s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '102s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '103s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '165s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '166s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '103s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '104s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '166s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '167s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '104s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '105s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '167s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '168s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '105s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '106s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '168s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '169s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '106s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '107s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '169s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '170s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '107s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '108s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '170s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '171s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '108s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '109s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '171s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '172s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '109s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '110s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '172s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '173s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '110s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '111s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '173s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '174s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '111s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '112s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '174s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '175s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '112s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '113s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '175s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '176s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '113s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '114s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '176s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '177s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '114s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '115s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '177s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '178s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '115s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '116s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '178s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '179s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '116s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '117s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '179s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '180s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '117s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '118s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '180s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '181s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '118s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '119s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '181s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '182s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '119s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '120s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '182s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '183s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '120s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '121s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '183s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '184s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '121s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '122s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '184s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '185s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '122s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '123s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '185s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '186s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '123s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '124s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '186s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '187s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '124s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '125s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '187s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '188s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '125s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '126s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '188s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '189s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '126s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '127s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '189s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '190s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '127s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '128s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '190s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '191s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '128s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '129s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '191s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '192s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '129s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '130s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '192s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '193s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '130s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '131s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '193s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '194s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '131s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '132s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '194s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '195s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '132s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '133s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '195s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '196s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '133s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '134s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '196s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '197s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '134s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '135s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '197s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '198s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '135s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '136s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '198s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '199s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '136s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '137s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '199s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '200s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '137s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '138s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '200s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '201s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '138s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '139s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '201s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '202s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '139s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '140s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '202s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '203s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '140s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '141s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '203s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '204s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '141s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '142s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '204s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '205s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '142s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '143s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '205s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '206s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '143s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '144s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '206s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '207s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '144s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '145s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '207s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '208s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '145s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '146s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '208s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '209s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh      
wait          
              
sed -i '146s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '147s/\/\///g' ../tb/tinybiriscv_soc_tb.v
sed -i '209s/^/\/\//g' ../tb/tinybiriscv_soc_tb.v
sed -i '210s/\/\///g' ../tb/tinybiriscv_soc_tb.v
./vcs.sh
wait
