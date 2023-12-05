#!/bin/bash

. $(dirname "$0")/config.sh

if grub-file --is-x86-multiboot $OUT_DIR/$OUT_BIN_FILE; then
  echo file is multiboot
else
  echo the file is not multiboot
fi