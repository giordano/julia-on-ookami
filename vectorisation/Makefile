# Based on
# <https://github.com/esiegmann/Ookami/blob/a4d11cbfd888ce96b6149f1c0434ce8c6f7d59d5/ExampleCodes/doesitvectorize/Makefile>
# by Eva Siegmann.

# The module command is available only to bash, not sh, which is the default.
SHELL = /bin/bash

SOURCE = vectorisation.cpp
LIBRARIES = libvectorisation_gcc_fast.so libvectorisation_gcc.so \
	libvectorisation_arm.so libvectorisation_arm.so \
	libvectorisation_llvm_fast.so libvectorisation_llvm.so \
	libvectorisation_cray_fast.so \
	libvectorisation_fujitsu_fast.so libvectorisation_fujitsu.so

# GCC 10.3 or later understands a64fx target
GCC_FLAGS = -Wall -mtune=a64fx -mcpu=a64fx -march=armv8.2-a+sve -fopt-info-vec -fopt-info-vec-missed -fopenmp

# By default, each line of Makefiles is executed in its own subshell, so that `module`
# commands have no effect on following commands in a recipe.  The special rule `.ONESHELL`
# tells make to run all commands within a recipe in a single shell.
.ONESHELL:

all: $(LIBRARIES)

libvectorisation_gcc_fast.so: $(SOURCE)
	module purge
	module load gcc/12.2.0
	g++ -Ofast -ffast-math $(GCC_FLAGS) $< -shared -o $@

libvectorisation_gcc.so: $(SOURCE)
	module purge
	module load gcc/12.2.0
	g++ -O3 $(GCC_FLAGS) $< -shared -o $@

# ARM clang
ARM_FLAGS = --std=c++17 -Wall -Rpass=loop-vectorize -march=armv8.2-a+sve -mcpu=a64fx -armpl -fopenmp

libvectorisation_arm_fast.so: $(SOURCE)
	module purge
	module load arm-modules/22.1
	armclang++ -Ofast -ffp-contract=fast -ffast-math $(ARM_FLAGS) $< -shared -o $@

libvectorisation_arm.so: $(SOURCE)
	module purge
	module load arm-modules/22.1
	armclang++ -O3 $(ARM_FLAGS) $< -shared -o $@

# LLVM
LLVM_FLAGS = --std=c++17 -Wall -Rpass=loop-vectorize -march=armv8.2-a+sve -mcpu=a64fx -fopenmp

libvectorisation_llvm_fast.so: $(SOURCE)
	module purge
	module load llvm/15.0.3
	clang++ -Ofast -ffp-contract=fast -ffast-math $(LLVM_FLAGS) $< -shared -o $@

libvectorisation_llvm.so: $(SOURCE)
	module purge
	module load llvm/15.0.3
	clang++ -O3 $(LLVM_FLAGS) $< -shared -o $@

# CRAY
libvectorisation_cray_fast.so: $(SOURCE)
	module purge
	module load CPE/22.03
	CC -O3 -h aggress,flex_mp=tolerant,msgs,negmsgs,vector3,omp $< -shared -o $@

libvectorisation_cray.so: $(SOURCE)
	module purge
	module load CPE/22.03
	CC -O3 -h msgs,negmsgs,vector3,omp $< -shared -o $@

# Fujitsu
FUJITSU_FLAGS = -KSVE -Koptmsg=2

libvectorisation_fujitsu_fast.so: $(SOURCE)
	module purge
	module load fujitsu/compiler/4.7
	FCC -Kfast $(FUJITSU_FLAGS) $< -shared -o $@

libvectorisation_fujitsu.so: $(SOURCE)
	module purge
	module load fujitsu/compiler/4.7
	FCC -O3 $(FUJITSU_FLAGS) $< -shared -o $@

clean:
	rm -f *.so
