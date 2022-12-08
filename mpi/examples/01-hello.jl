using MPI
MPI.Init(; threadlevel=:single)

comm = MPI.COMM_WORLD
print("Hello world from $(MPI.Get_processor_name()), I am rank $(MPI.Comm_rank(comm)) of $(MPI.Comm_size(comm))\n")
MPI.Barrier(comm)
