#!/bin/bash

# Directories
GEM5_DIR='/home/andrew/ece511/gem5'
GEM5_BUILD_DIR='build/ARM'
CONF_DIR='configs/example'
LIBQUANTUM='/home/andrew/ece511/libquantum/libquantum_base.arm'
SOPLEX='/home/andrew/ece511/soplex/soplex_base.arm'

CPU_TYPE='O3_ARM_v7a_3'
BP_TYPE='LocalBP'

BINARY_ARGS_L='33 5'
BINARY_ARGS_S='-m10000 /home/andrew/ece511/soplex/test.mps'

# Number of CPU's
NUM_CPUS=1

# L1 Cache Settings
L1I_SIZE='16kB'
L1D_SIZE='64kB'

# L2 Cache Settings
L2_SIZE='256kB'

# None
$GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
  --outdir="mp2_data/None_libquantum" \
  $GEM5_DIR/$CONF_DIR/se.py \
  --cmd=$LIBQUANTUM \
  --options="$BINARY_ARGS_L" \
  --num-cpus=$NUM_CPUS \
  --cpu-type=$CPU_TYPE \
  --bp_type="None" \
  --l1i_size=$L1I_SIZE \
  --l1d_size=$L1D_SIZE \
  --l2cache \
  --l2_size=$L2_SIZE \
  --caches > ./logs/None_libquantum.log &

$GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
  --outdir="mp2_data/None_soplex" \
  $GEM5_DIR/$CONF_DIR/se.py \
  --cmd=$SOPLEX \
  --options="$BINARY_ARGS_S" \
  --num-cpus=$NUM_CPUS \
  --cpu-type=$CPU_TYPE \
  --bp_type="None" \
  --l1i_size=$L1I_SIZE \
  --l1d_size=$L1D_SIZE \
  --l2cache \
  --l2_size=$L2_SIZE \
  --caches > ./logs/None_soplex.log &

# Tournament
$GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
  --outdir="mp2_data/TournamentBP_libquantum" \
  $GEM5_DIR/$CONF_DIR/se.py \
  --cmd=$LIBQUANTUM \
  --options="$BINARY_ARGS_L" \
  --num-cpus=$NUM_CPUS \
  --cpu-type=$CPU_TYPE \
  --bp_type="TournamentBP" \
  --l1i_size=$L1I_SIZE \
  --l1d_size=$L1D_SIZE \
  --l2cache \
  --l2_size=$L2_SIZE \
  --caches > ./logs/TournamentBP_libquantum.log &

$GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
  --outdir="mp2_data/TournamentBP_soplex" \
  $GEM5_DIR/$CONF_DIR/se.py \
  --cmd=$SOPLEX \
  --options="$BINARY_ARGS_S" \
  --num-cpus=$NUM_CPUS \
  --cpu-type=$CPU_TYPE \
  --bp_type="TournamentBP" \
  --l1i_size=$L1I_SIZE \
  --l1d_size=$L1D_SIZE \
  --l2cache \
  --l2_size=$L2_SIZE \
  --caches > ./logs/TournamentBP_soplex.log &

# LTAGE
$GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
  --outdir="mp2_data/LTAGE_libquantum" \
  $GEM5_DIR/$CONF_DIR/se.py \
  --cmd=$LIBQUANTUM \
  --options="$BINARY_ARGS_L" \
  --num-cpus=$NUM_CPUS \
  --cpu-type=$CPU_TYPE \
  --bp_type="LTAGE" \
  --l1i_size=$L1I_SIZE \
  --l1d_size=$L1D_SIZE \
  --l2cache \
  --l2_size=$L2_SIZE \
  --caches > ./logs/LTAGE_libquantum.log &

$GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
  --outdir="mp2_data/LTAGE_soplex" \
  $GEM5_DIR/$CONF_DIR/se.py \
  --cmd=$SOPLEX \
  --options="$BINARY_ARGS_S" \
  --num-cpus=$NUM_CPUS \
  --cpu-type=$CPU_TYPE \
  --bp_type="LTAGE" \
  --l1i_size=$L1I_SIZE \
  --l1d_size=$L1D_SIZE \
  --l2cache \
  --l2_size=$L2_SIZE \
  --caches > ./logs/LTAGE_soplex.log &

# LocalBP
LOCALBP_GLOBAL_PRED_SIZE=('2048' '4096')
for i in "${LOCALBP_GLOBAL_PRED_SIZE[@]}"
  do
    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/LocalBP_libquantum_${i}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$LIBQUANTUM \
      --options="$BINARY_ARGS_L" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="LocalBP" \
      --local_pred_size=${i} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/LocalBP_libquantum_${i}.log &

    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/LocalBP_soplex_${i}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$SOPLEX \
      --options="$BINARY_ARGS_S" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="LocalBP" \
      --local_pred_size=${i} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/LocalBP_soplex_${i}.log &
done

# BiModeBP
BM_CHOICE_PRED_SIZE=('2048' '4096')
BM_GLOBAL_PRED_SIZE=('1024' '2048')
for idx in ${!BM_CHOICE_PRED_SIZE[*]}
  do
    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/BiModeBP_libquantum_${BM_CHOICE_PRED_SIZE[$idx]}_${BM_GLOBAL_PRED_SIZE[$idx]}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$LIBQUANTUM \
      --options="$BINARY_ARGS_L" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="BiModeBP" \
      --global_pred_size=${BM_GLOBAL_PRED_SIZE[$idx]} \
      --choice_pred_size=${BM_CHOICE_PRED_SIZE[$idx]} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/BiModeBP_libquantum_${BM_CHOICE_PRED_SIZE[$idx]}_${BM_GLOBAL_PRED_SIZE[$idx]}.log &

    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/BiModeBP_soplex_${BM_CHOICE_PRED_SIZE[$idx]}_${BM_GLOBAL_PRED_SIZE[$idx]}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$SOPLEX \
      --options="$BINARY_ARGS_S" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="BiModeBP" \
      --global_pred_size=${BM_GLOBAL_PRED_SIZE[$idx]} \
      --choice_pred_size=${BM_CHOICE_PRED_SIZE[$idx]} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/BiModeBP_soplex_${BM_CHOICE_PRED_SIZE[$idx]}_${BM_GLOBAL_PRED_SIZE[$idx]}.log &
done

# GShareBP
GSHAREBP_PHT_PRED_SIZE=('2048' '4096')
for i in "${GSHAREBP_PHT_PRED_SIZE[@]}"
  do
    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/GShareBP_libquantum_${i}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$LIBQUANTUM \
      --options="$BINARY_ARGS_L" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="GShareBP" \
      --pht_pred_size=${i} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/GShareBP_libquantum_${i}.log &

    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/GShareBP_soplex_${i}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$SOPLEX \
      --options="$BINARY_ARGS_S" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="GShareBP" \
      --local_pred_size=${i} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/GShareBP_soplex_${i}.log &
done

# YagsBP
YAGSBP_CHOICE_PRED_SIZE=('2048' '2048' '4096' '4096')
YAGSBP_GLOBAL_PRED_SIZE=('1024' '2048' '1024' '2048')
for idx in ${!YAGSBP_CHOICE_PRED_SIZE[*]}
  do
    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/YagsBP_libquantum_${YAGSBP_CHOICE_PRED_SIZE[$idx]}_${YAGSBP_GLOBAL_PRED_SIZE[$idx]}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$LIBQUANTUM \
      --options="$BINARY_ARGS_L" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="YagsBP" \
      --global_pred_size=${YAGSBP_GLOBAL_PRED_SIZE[$idx]} \
      --choice_pred_size=${YAGSBP_CHOICE_PRED_SIZE[$idx]} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/YagsBP_libquantum_${YAGSBP_CHOICE_PRED_SIZE[$idx]}_${YAGSBP_GLOBAL_PRED_SIZE[$idx]}.log &

    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/YagsBP_soplex_${YAGSBP_CHOICE_PRED_SIZE[$idx]}_${YAGSBP_GLOBAL_PRED_SIZE[$idx]}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$SOPLEX \
      --options="$BINARY_ARGS_S" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="YagsBP" \
      --global_pred_size=${YAGSBP_GLOBAL_PRED_SIZE[$idx]} \
      --choice_pred_size=${YAGSBP_CHOICE_PRED_SIZE[$idx]} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/YagsBP_soplex_${YAGSBP_CHOICE_PRED_SIZE[$idx]}_${YAGSBP_GLOBAL_PRED_SIZE[$idx]}.log &
done

# GShareBP
PERCEPT_HISTORY_SIZE=('12' '24' '48')
for i in "${PERCEPT_HISTORY_SIZE[@]}"
  do
    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/PerceptronBP_libquantum_${i}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$LIBQUANTUM \
      --options="$BINARY_ARGS_L" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="PerceptronBP" \
      --hist_reg_bits=${i} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/PerceptronBP_libquantum_${i}.log &

    $GEM5_DIR/$GEM5_BUILD_DIR/gem5.fast \
      --outdir="mp2_data/PerceptronBP_soplex_${i}" \
      $GEM5_DIR/$CONF_DIR/se.py \
      --cmd=$SOPLEX \
      --options="$BINARY_ARGS_S" \
      --num-cpus=$NUM_CPUS \
      --cpu-type=$CPU_TYPE \
      --bp_type="PerceptronBP" \
      --hist_reg_bits=${i} \
      --l1i_size=$L1I_SIZE \
      --l1d_size=$L1D_SIZE \
      --l2cache \
      --l2_size=$L2_SIZE \
      --caches > ./logs/PerceptronBP_soplex_${i}.log &
done
