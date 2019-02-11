#!/bin/bash

CACHE_SIZES=('64kB' '128kB' '256kB')
MAT_SIZE='128'
TILE_SIZES=('1' '2' '4' '8' '16' '32' '64')

GEM5_DIR='/home/andrew/ece511/gem5'
GEM5_BUILD='build/ARM/gem5.fast'
OUTPUT_DIR='1.2_fs'
CONFIG_FILE='configs/example/fs.py'
IMAGE='aarch32-ubuntu-natty-headless.img'
#IMAGE='benchmarks/FSmode/disks/aarch32-ubuntu-natty-headless.img'
KERNEL='benchmarks/FSmode/binaries/vmlinux.aarch32.ll_20131205.0-gem5'
DTB='benchmarks/FSmode/binaries/vexpress.aarch32.ll_20131205.0-gem5.1cpu.dtb'
CHKPT_DIR='checkpoint'

for i in "${CACHE_SIZES[@]}"
do
  for j in "${TILE_SIZES[@]}"
  do
    $GEM5_BUILD -d $OUTPUT_DIR/"${i}_${MAT_SIZE}_${j}" $CONFIG_FILE \
      --machine-type=VExpress_EMM \
      --disk-image=$GEM5_DIR/$IMAGE \
      --kernel=$GEM5_DIR/$KERNEL \
      --dtb-filename=$GEM5_DIR/$DTB \
      --restore-with-cpu=TimingSimpleCPU \
      --num-cpus=2 --caches --l2cache --l2_size=$i \
      --script="$GEM5_DIR/mat_mul_rcs/mat_mul_${MAT_SIZE}_${j}.rcs" \
      --checkpoint-dir=$GEM5_DIR/$OUTPUT_DIR/$CHKPT_DIR -r 1 &
  done
done
