#!/usr/bin/zsh

source_file="demo.asm"
file_name=${source_file%.asm}
robot_file="./${file_name}"
assembly_file="./${file_name}.o"

echo $file_name
if [ -f "${robot_file}" ]; then
    rm -rf $robot_file
elif [ -f "${assembly_file}" ]; then
    rm -rf $assembly_file
fi

`(as $source_file -o $assembly_file && ld $assembly_file -o $robot_file && "$robot_file" >> run.log)`