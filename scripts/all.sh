#!/bin/bash

SCRIPT_DIRECTORY=$(dirname "$0")
cd $SCRIPT_DIRECTORY

. ./config.sh

./clean.sh
echo --- Building
./build.sh &&
echo --- Checking multiboot &&
./multiboot_check.sh &&
echo --- Generating .iso &&
./iso.sh &&
echo --- Starting QEMU &&
./bochs.sh &&
echo --- Cleaning up &&
./clean.sh