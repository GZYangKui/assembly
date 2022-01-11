#!/usr/bin/env bash
#判断是否传递待编译及连接的文件
if [ -z $1 ]; then
    echo "Usage:./asm64 <asm64MainFile> (no execution)"
fi
#判断文件是否存在
if [ ! -e "$1.asm" ]; then
  echo "Error:$1.asm file not found!"
  exit
fi

yasm -Worphan-labels -g dwarf2 -f elf64 $1.asm -l $1.lst -o $1.o && ld -g -o $1 $1.o
#ddd $1
#$1