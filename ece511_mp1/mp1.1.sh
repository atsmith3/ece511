#!/bin/bash

# Directories
GEM5_DIR='/home/andrew/ece511/gem5'
GEM5_BUILD_DIR='build/ARM'
MP_DIR='ece511/ece511_mp1'
CONF_DIR='configs/example'

BINARY_ARGS='-m16 -p2'

# Number of CPU's
NUM_CPUS=2

# L1 Cache Settings
L1I_SIZE='64kB'
L1D_SIZE='64kB'
L1I_ASSOC=8
L1D_ASSOC=8

# L2 Cache Settings
L2_SIZE='256kB'
NUM_L2CACHES=$NUM_CPUS
L2_ASSOC=8

# L3 Cache Settings
#L3_SIZE='1MB'
#NUM_L3CACHES=$NUM_CPUS
#L3_ASSOC=8


#$GEM5_DIR/$GEM5_BUILD_DIR/gem5.opt \
#--outdir=$GEM5_DIR/$MP_DIR/1.1_result \
#--json-config=mp1.1.json \
#$GEM5_DIR/$CONF_DIR/se.py \
#-h \


$GEM5_DIR/$GEM5_BUILD_DIR/gem5.opt \
--outdir=$GEM5_DIR/$MP_DIR/1.1_result \
--json-config=mp1.1.json \
$GEM5_DIR/$CONF_DIR/se.py \
--cmd=$GEM5_DIR/$MP_DIR/fft \
--options="$BINARY_ARGS" \
--cpu-type=TimingSimpleCPU \
--l1i_size=$L1I_SIZE \
--l1i_assoc=$L1I_ASSOC \
--l1d_size=$L1D_SIZE \
--l1d_assoc=$L1D_ASSOC \
--l2cache \
--l2_size=$L2_SIZE \
--l2_assoc=$L2_ASSOC \
--num-l2caches=$NUM_L2CACHES \
--ruby 
