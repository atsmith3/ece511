#!/bin/bash

GEM5_DIR='/home/andrew/ece511/gem5'
GEM5_BUILD='build/ARM/gem5.fast'
OUTPUT_DIR='1.2_fs'
RCS_SCRIPT='mat_mul.rcs'
CONFIG_FILE='configs/example/fs.py'
IMAGE='aarch32-ubuntu-natty-headless.img'
#IMAGE='benchmarks/FSmode/disks/aarch32-ubuntu-natty-headless.img'
KERNEL='benchmarks/FSmode/binaries/vmlinux.aarch32.ll_20131205.0-gem5'
DTB='benchmarks/FSmode/binaries/vexpress.aarch32.ll_20131205.0-gem5.1cpu.dtb'
CHKPT_DIR='checkpoint'

$GEM5_BUILD -d $OUTPUT_DIR/64kB $CONFIG_FILE \
--machine-type=VExpress_EMM \
--disk-image=$GEM5_DIR/$IMAGE \
--kernel=$GEM5_DIR/$KERNEL \
--dtb-filename=$GEM5_DIR/$DTB \
--restore-with-cpu=TimingSimpleCPU \
--num-cpus=2 --caches --l2cache --l2_size='64kB' \
--script=$GEM5_DIR/$RCS_SCRIPT \
--checkpoint-dir=$GEM5_DIR/$OUTPUT_DIR/$CHKPT_DIR -r 1 &
