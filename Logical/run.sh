#!/bin/bash
#编译公共模块数据
yasm -g dwarf2 -f elf64  ../IO.asm
yasm -g dwarf2 -f elf64 ../Sys.asm
yasm -g dwarf2 -f elf64  Main.asm -l Main.lst
ld -g -o Main Main.o  IO.o  Sys.o
