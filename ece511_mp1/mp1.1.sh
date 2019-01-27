#!/bin/bash

# Directories
GEM5_DIR='/home/andrew/ece511/gem5'
GEM5_BUILD_DIR='build/ARM'
MP_DIR='ece511/ece511_mp1'

$GEM5_DIR/$GEM5_BUILD_DIR/gem5.opt \
--outdir=$MP_DIR/1.1_result \
$GEM5_DIR/$MP_DIR/1.1_config/two_level.py \
$GEM5_DIR/$MP_DIR/fft
