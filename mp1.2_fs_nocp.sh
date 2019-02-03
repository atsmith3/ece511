#!/bin/bash

CACHE_SIZES=('64kB' '128kB' '256kB')

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

for i in "${CACHE_SIZES[@]}"; do
$GEM5_BUILD -d $OUTPUT_DIR/$i $CONFIG_FILE \
  --machine-type=VExpress_EMM \
  --disk-image=$GEM5_DIR/$IMAGE \
  --kernel=$GEM5_DIR/$KERNEL \
  --dtb-filename=$GEM5_DIR/$DTB \
  --cpu-type=TimingSimpleCPU \
  --num-cpus=2 --caches --l2cache --l2_size=$i \
  --script=$GEM5_DIR/$RCS_SCRIPT &;
done
#  --checkpoint-dir=$GEM5_DIR/$OUTPUT_DIR/$CHKPT_DIR -r 1 &
