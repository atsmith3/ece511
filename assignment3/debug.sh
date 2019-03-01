gdb --command=debug.bp --args build/ARM/gem5.debug\
  --outdir=./output_logs/debug\
  ./configs/example/se.py\
  --cmd=/home/andrew/ece511/libquantum/libquantum_base.arm\
  --options='33 5'\
  --cpu-type=O3_ARM_v7a_3\
  --num-cpus=1 --caches --l2cache\
  --prefetch_type=Markov --prefetch_num_missed_addrs=4 --prefetch_threshold=1
