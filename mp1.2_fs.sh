#!/bin/bash

GEM5_DIR='/home/andrew/ece511/gem5'
GEM5_BUILD='build/ARM/gem5.fast'
OUTPUT_DIR='1.2_fs'
RCS_SCRIPT='test.rcS'
CONFIG_FILE='configs/example/fs.py'
#IMAGE='aarch32-ubuntu-natty-headless.img'
IMAGE='benchmarks/FSmode/disks/aarch32-ubuntu-natty-headless.img'
KERNEL='benchmarks/FSmode/binaries/vmlinux.aarch32.ll_20131205.0-gem5'
DTB='benchmarks/FSmode/binaries/vexpress.aarch32.ll_20131205.0-gem5.1cpu.dtb'
CHKPT_DIR='benchmarks/FSmode/m5out'

$GEM5_BUILD -d $OUTPUT_DIR $CONFIG_FILE \
--script=$GEM5_DIR/$RCS_SCRIPT \
--machine-type=VExpress_EMM \
--disk-image=$GEM5_DIR/$IMAGE \
--kernel=$GEM5_DIR/$KERNEL \
--dtb-filename=$GEM5_DIR/$DTB \
--cpu-type=AtomicSimpleCPU \
--num-cpus=1 --caches --l2cache \
--checkpoint-dir=$GEM5_DIR/$CHKPT_DIR -r 1
