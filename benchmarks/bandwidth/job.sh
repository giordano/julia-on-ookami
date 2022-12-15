#!/bin/bash

#SBATCH --job-name=julia_bandwidth
#SBATCH --output=julia_bandwidth.log
#SBATCH -N 1
#SBATCH --time=00:20:00
#SBATCH --cpus-per-task=48
#SBATCH -p short

# Load Julia module
module load julia/nightly-5da8d5f17a

# execute job
julia --project=. --threads=48 bench.jl
