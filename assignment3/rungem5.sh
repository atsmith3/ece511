#!/bin/bash

# 4800197583000

case "$1" in
	"calibrate")
		date=$(date +%d%b%Y.%H%M)
		debugFlags=RubySlicc
		outputDir="./output_logs/calibrate"
		outName="m5out_${bname}"
		DIR="$( cd "$( dirname "$0" )" && pwd )"
		diskImage="${DIR}/disks/x86root-parsec.img"
		kernelImage="${DIR}/binaries/vmlinux"
		build/X86/gem5.opt\
			--outdir=${outputDir} --remote-gdb-port=0 configs/example/fs.py\
			--kernel=${kernelImage} --num-cpus=8 --caches --l2cache\
			--disk-image=${diskImage} --script=calibrate.rcS 
		;;
	"tagged")
		date=$(date +%d%b%Y.%H%M)
		debugFlags=RubySlicc
		case $2 in
			"blackscholes")
				bname="blackscholes"
				script="./blackscholes.rcS"
				;;

			"bodytrack")
				bname="bodytrack"
				script="./bodytrack.rcS"
				;;

			"fluidanimate")
				bname="fluidanimate"
				script="./fluidanimate.rcS"
				;;

			"x264")
				bname="x264"
				script="./x264.rcS"
				;;
			*)
				echo "Usage:
				$0 build {MI|MSI|MESI|tagged}
				$0 run {blackscholes|bodytrack|fluidanimate|x264}
				$0 runall
				$0 tagged {blackscholes|bodytrack|fluidanimate|x264}"
				exit
				;;
		esac
		# outputDir="./output_logs/${bname}/${date}"
		outputDir="./output_logs/${bname}"
		outName="m5out_${bname}"
		DIR="$( cd "$( dirname "$0" )" && pwd )"
		diskImage="${DIR}/disks/x86root-parsec.img"
		kernelImage="${DIR}/binaries/vmlinux"
		time build/X86/gem5.opt\
			--outdir=${outputDir} --remote-gdb-port=0 configs/example/fs.py\
			--kernel=${kernelImage} --num-cpus=8 --caches --l2cache\
			--disk-image=${diskImage} --script=${script} --standard-switch 4998864102000\
			-I 1000000000
			
		;;
	"build")
		case $2 in
			"MI")
				protocol="MI_example"
				;;
			"MSI")
				protocol="MSI_Two_Level"
				;;
			"MESI")
				protocol="MESI_Two_Level"
				;;
			"tagged")
				scons -j8 build/X86/gem5.opt
				exit
				;;
			*)
				echo "Usage:
				$0 build {MI|MSI|MESI|tagged}
				$0 run {blackscholes|bodytrack|fluidanimate|x264}
				$0 runall
				$0 tagged {blackscholes|bodytrack|fluidanimate|x264}"
				exit
				;;
		esac
		scons build/X86/gem5.opt -j8 RUBY=True PROTOCOL=$protocol SLICC_HTML=True
		;;

	"run")
		date=$(date +%d%b%Y.%H%M)
		debugFlags=RubySlicc
		case $2 in
			"blackscholes")
				bname="blackscholes"
				script="./blackscholes.rcS"
				;;

			"bodytrack")
				bname="bodytrack"
				script="./bodytrack.rcS"
				;;

			"fluidanimate")
				bname="fluidanimate"
				script="./fluidanimate.rcS"
				;;

			"x264")
				bname="x264"
				script="./x264.rcS"
				;;
			*)
				echo "Usage:
				$0 build {MI|MSI|MESI|tagged}
				$0 run {blackscholes|bodytrack|fluidanimate|x264}
				$0 runall
				$0 tagged {blackscholes|bodytrack|fluidanimate|x264}"
				exit
				;;
		esac
		# outputDir="./output_logs/${bname}/${date}"
		outputDir="./output_logs/${bname}"
		outName="m5out_${bname}"
		DIR="$( cd "$( dirname "$0" )" && pwd )"
		diskImage="${DIR}/disks/x86root-parsec.img"
		kernelImage="${DIR}/binaries/vmlinux"
		
		time build/X86/gem5.opt\
			--outdir=${outputDir} --remote-gdb-port=0 configs/example/fs.py\
			--kernel=${kernelImage} --ruby --num-cpus=8 --caches --l2cache\
			--disk-image=${diskImage} --script=${script} --cpu-type=TimingSimpleCPU\
			--num-dirs=8 --num-l2caches=8 --topology=Crossbar -I 300000000
		;;
	runall)
		for bname in "blackscholes" "bodytrack" "fluidanimate" "x264"
		do
			date=$(date +%d%b%Y.%H%M)
			debugFlags=RubySlicc
			case $bname in
				"blackscholes")
					script="./blackscholes.rcS"
					;;

				"bodytrack")
					script="./bodytrack.rcS"
					;;

				"fluidanimate")
					script="./fluidanimate.rcS"
					;;

				"x264")
					script="./x264.rcS"
					;;
			esac
			outputDir="./output_logs/${bname}"
			outName="m5out_${bname}"
			DIR="$( cd "$( dirname "$0" )" && pwd )"
			diskImage="${DIR}/disks/x86root-parsec.img"
			kernelImage="${DIR}/binaries/vmlinux"
      
#      PREFETCH=('' 'Markov' 'Stride' 'Tagged')
      PREFETCH=('Stride' 'Tagged')
#      PREFETCH_OPTS=('' 
#                     '--prefetch_type=Markov --prefetch_threshold=32 --prefetch_num_prediction_registers=4 --prefetch_num_load=2 --prefetch_num_missed_addrs=128'
#                     '--prefetch_type=Stride' 
#                     '--prefetch_type=Tagged')
      PREFETCH_OPTS=('--prefetch_type=Stride' 
                     '--prefetch_type=Tagged')

      for idx in ${!PREFETCH[*]}
        do
      		build/X86/gem5.opt\
      			--outdir=${outputDir}_${PREFETCH[$idx]} --remote-gdb-port=0 configs/example/fs.py\
  	    		--kernel=${kernelImage} --num-cpus=8 --caches --l2cache\
            ${PREFETCH_OPTS[$idx]}\
  	    		--disk-image=${diskImage} --script=${script} --standard-switch 4000000000000\
  	    		-I 1000000000 &
      done
# 4998864102000
#			time build/X86/gem5.opt\
#				--outdir=${outputDir} --remote-gdb-port=0 configs/example/fs.py\
#				--kernel=${kernelImage} --ruby --num-cpus=8 --caches --l2cache\
#				--disk-image=${diskImage} --script=${script} --cpu-type=TimingSimpleCPU\
#				--num-dirs=8 --num-l2caches=8 --topology=Crossbar -I 300000000
		done
		;;
	*)
		echo "Usage:
		$0 build {MI|MSI|MESI|tagged}
		$0 run {blackscholes|bodytrack|fluidanimate|x264}
		$0 runall
		$0 tagged {blackscholes|bodytrack|fluidanimate|x264}"
		;;
esac
