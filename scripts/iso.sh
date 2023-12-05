#!/bin/bash

. $(dirname "$0")/config.sh

mkdir -p $OUT_DIR/iso/boot/grub
cp $OUT_DIR/$OUT_BIN_FILE $OUT_DIR/iso/boot/$OUT_BIN_FILE
cp $SRC_DIR/grub.cfg $OUT_DIR/iso/boot/grub/grub.cfg
grub-mkrescue -o $OUT_DIR/$OUT_ISO_FILE $OUT_DIR/iso