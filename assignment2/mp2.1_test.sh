#!/bin/bash

# Directories
GEM5_DIR='/home/andrew/ece511/gem5'
GEM5_BUILD_DIR='build/ARM'
CONF_DIR='configs/example'
LIBQUANTUM='/home/andrew/ece511/libquantum/libquantum_base.arm'

BINARY_ARGS='33 5'

# Number of CPU's
NUM_CPUS=2

# L1 Cache Settings
L1I_SIZE='16kB'
L1D_SIZE='64kB'

# L2 Cache Settings
L2_SIZE='256kB'

$GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
--outdir=mp2.2_test \
$GEM5_DIR/$CONF_DIR/se.py \
--cmd=$LIBQUANTUM \
--options="$BINARY_ARGS" \
--num-cpus=$NUM_CPUS \
--cpu-type=TimingSimpleCPU \
--l1i_size=$L1I_SIZE \
--l1d_size=$L1D_SIZE \
--l2cache \
--l2_size=$L2_SIZE \
--caches > mp2.2_test.log &
