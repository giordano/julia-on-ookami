using MPI, Statistics

MPI.Init(; threadlevel=:single)
const comm = MPI.COMM_WORLD
const root = 0
const rank = MPI.Comm_rank(comm)

sum_of_ranks = MPI.Reduce(rank, +, root, comm)

if rank == root
    println("sum of ranks = $(sum_of_ranks)")
end
