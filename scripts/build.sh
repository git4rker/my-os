#!/bin/bash

. $(dirname "$0")/config.sh

mkdir -p $OUT_DIR

nasm -felf32 $SRC_DIR/boot.asm -o $OUT_DIR/boot.o || exit 1
for i in ${!GCC_C_FILES[*]}; do
    i686-elf-gcc -c $SRC_DIR/${GCC_C_FILES[$i]} -o $OUT_DIR/${GCC_OBJ_FILES[$i]} $GCC_FLAGS -g
    if [ $? -ne 0 ]; then
        echo Uh-oh.
        exit 1
    fi
done

linker_files=""
for obj in ${GCC_OBJ_FILES[@]}; do
    linker_files+=$OUT_DIR/$obj
    linker_files+=' '
done
i686-elf-gcc -T $SRC_DIR/linker.ld -o $OUT_DIR/$OUT_BIN_FILE $LINKER_FLAGS $OUT_DIR/boot.o $linker_files -g
if [ $? -ne 0 ]; then
    echo Uh-oh.
    exit 1
fi