#!/bin/bash

SCRIPT_DIRECTORY=$(realpath `dirname "$0"`)
cd $SCRIPT_DIRECTORY/..

SRC_DIR=src
OUT_DIR=out
OUT_BIN_FILE=os.bin
OUT_ISO_FILE=os.iso
GCC_FLAGS="-std=gnu99 -ffreestanding -O2 -Wall -Wextra -Isrc/include"
LINKER_FLAGS="-ffreestanding -O2 -nostdlib -lgcc"
GCC_C_FILES=(kernel.c include/terminal/tty.c include/string/memcmp.c include/string/memcpy.c
             include/string/memmove.c include/string/memset.c include/string/itoa.c
             include/terminal/dio.c include/string/strcpy.c)

GCC_OBJ_FILES=()

for c in "${GCC_C_FILES[@]}"; do
    c_basename=$(basename ${c})
    GCC_OBJ_FILES+=(${c_basename%.c}.o)
done