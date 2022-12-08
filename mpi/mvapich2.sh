#!/usr/bin/env bash

#SBATCH --job-name=julia_mvapich2
#SBATCH --output=julia_mvapich2.log
#SBATCH -N 4
#SBATCH --time=00:05:00
#SBATCH --ntasks-per-node=1
#SBATCH -p short

# Load MVAPICH2 and Julia
module load slurm gcc/11.1.0 mvapich2/gcc11/2.3.6 julia/nightly-5da8d5f17a

# Run Julia with MPI.  Remember to specify the project!
srun julia --project=mvapich2 examples/01-hello.jl
# srun julia --project=mvapich2 examples/02-broadcast.jl
# srun julia --project=mvapich2 examples/03-reduce.jl
# srun julia --project=mvapich2 examples/04-sendrecv.jl
# srun julia --project=mvapich2 examples/05-job_schedule.jl
# srun julia --project=mvapich2 examples/06-scatterv.jl
# srun julia --project=mvapich2 examples/07-rma_active.jl
# srun julia --project=mvapich2 examples/08-rma_passive.jl
# srun julia --project=mvapich2 examples/09-graph_communication.jl
