#!/bin/bash

vlogan -f include.f  +v2k -l vlogan.log -full64 -timescale=1ns/1ps
vcs tinybiriscv_soc_tb -o simv -l tb.log -debug_all -full64 +neg_tchk +sdfverbose +maxdelays -negdelay -sdfretain 
./simv -gui
