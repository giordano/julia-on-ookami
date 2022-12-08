#!/usr/bin/env bash

#SBATCH --job-name=julia_openmpi
#SBATCH --output=julia_openmpi.log
#SBATCH -N 4
#SBATCH --time=00:05:00
#SBATCH --cpus-per-task=1
#SBATCH -p short

# specify message size threshold for using the UCX Rendevous Protocol
export UCX_RNDV_THRESH=65536

# use high-performance rc transports where possible
export UCX_TLS=rc

# Load OpenMPI and Julia
module load slurm gcc/12.1.0 ucx/1.11.2 openmpi/gcc12.1.0/4.1.4 julia/nightly-5da8d5f17a

# Run Julia with MPI.  Remember to specify the project!
mpiexec --map-by ppr:1:node:pe=48 --report-bindings julia --project=openmpi examples/01-hello.jl
# mpiexec --map-by ppr:1:node:pe=48 --report-bindings julia --project=openmpi examples/02-broadcast.jl
# mpiexec --map-by ppr:1:node:pe=48 --report-bindings julia --project=openmpi examples/03-reduce.jl
# mpiexec --map-by ppr:1:node:pe=48 --report-bindings julia --project=openmpi examples/04-sendrecv.jl
# mpiexec --map-by ppr:1:node:pe=48 --report-bindings julia --project=openmpi examples/05-job_schedule.jl
# mpiexec --map-by ppr:1:node:pe=48 --report-bindings julia --project=openmpi examples/06-scatterv.jl
# mpiexec --map-by ppr:1:node:pe=48 --report-bindings julia --project=openmpi examples/07-rma_active.jl
# mpiexec --map-by ppr:1:node:pe=48 --report-bindings julia --project=openmpi examples/08-rma_passive.jl
# mpiexec --map-by ppr:1:node:pe=48 --report-bindings julia --project=openmpi examples/09-graph_communication.jl
