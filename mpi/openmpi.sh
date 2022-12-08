#!/usr/bin/env bash

#SBATCH --job-name=julia_mpi
#SBATCH --output=julia_mpi.log
#SBATCH -N 4
#SBATCH --time=00:05:00
#SBATCH --cpus-per-task=2
#SBATCH -p short

# specify message size threshold for using the UCX Rendevous Protocol
export UCX_RNDV_THRESH=65536

# use high-performance rc transports where possible
export UCX_TLS=rc

# control how much information about the transports is printed to log
export UCX_LOG_LEVEL=info

# Load OpenMPI and Julia
module load slurm gcc/12.1.0 ucx/1.11.2 openmpi/gcc12.1.0/4.1.4 julia/nightly-5da8d5f17a

# Run Julia with MPI.  Remember to specify the project!
mpiexec --map-by ppr:2:node:pe=24 --report-bindings julia --project=openmpi examples/01-hello.jl
