#!/usr/bin/env bash

#SBATCH --job-name=julia_mpi
#SBATCH --output=julia_mpi.log
#SBATCH -N 4
#SBATCH --time=00:05:00
#SBATCH --cpus-per-task=2
#SBATCH -p short

# Load MVAPICH2 and Julia
module load slurm gcc/11.1.0 mvapich2/gcc11/2.3.6 julia/nightly-5da8d5f17a

# Run Julia with MPI.  Remember to specify the project!
srun julia --project=mvapich2 examples/01-hello.jl
