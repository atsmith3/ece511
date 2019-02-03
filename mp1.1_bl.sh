#!/bin/bash

# Directories
GEM5_DIR='/home/andrew/ece511/gem5'
GEM5_BUILD_DIR='build/ARM'
CONF_DIR='configs/example'

BINARY_ARGS='-m16 -p2'

# Number of CPU's
NUM_CPUS=2

# L1 Cache Settings
L1I_SIZE='16kB'
L1D_SIZE='64kB'

# L2 Cache Settings
L2_SIZE='256kB'

$GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
--outdir=$GEM5_DIR/1.1_bl_fft \
$GEM5_DIR/$CONF_DIR/se.py \
--cmd=$GEM5_DIR/fft \
--options="$BINARY_ARGS" \
--num-cpus=$NUM_CPUS \
--cpu-type=TimingSimpleCPU \
--l1i_size=$L1I_SIZE \
--l1d_size=$L1D_SIZE \
--l2cache \
--l2_size=$L2_SIZE \
--caches > 1.1_bl_fft.out &

$GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
--outdir=$GEM5_DIR/1.1_bl_cm \
$GEM5_DIR/$CONF_DIR/se.py \
--cmd=$GEM5_DIR/correlation_medium \
--num-cpus=$NUM_CPUS \
--cpu-type=TimingSimpleCPU \
--l1i_size=$L1I_SIZE \
--l1d_size=$L1D_SIZE \
--l2cache \
--l2_size=$L2_SIZE \
--caches > 1.1_bl_cm.out &
