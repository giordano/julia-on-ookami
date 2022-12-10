# Julia on A64FX @ Ookami

This repository contains some material for the "Julia on A64FX" webinar held for users of
the [Ookami](https://www.stonybrook.edu/ookami/) system @ Stony Brook University on
2022-12-08 ([video recording](https://www.youtube.com/watch?v=kZNYFWGnixA)).

Some generic information about Julia on A64FX can be found in the repository
[julia-on-fugaku](https://github.com/giordano/julia-on-fugaku/), and the paper [Productivity
meets Performance: Julia on A64FX](https://doi.org/10.1109/CLUSTER51413.2022.00072),
presented at the 2022 IEEE International Conference on Cluster Computing (CLUSTER22), as
part of the [Embracing Arm for High Performance Computing
Workshop](https://arm-hpc-user-group.github.io/eahpc-2022/) (pre-print available on arXiv:
[`2207.12762`](https://arxiv.org/abs/2207.12762)).  Below are some information specific to
the use of Julia on Ookami.

## Julia modules

Julia modules are available on Ookami.  As of this writing (2022-12-04) there are

* `julia/1.6.0`
* `julia/1.7.0`
* `julia/1.8.2`
* `julia/nightly-5da8d5f17a` (corresponds to Julia commit
  [`5da8d5f17a`](https://github.com/JuliaLang/julia/commit/5da8d5f17ad9505fdb425c302f3dbac36eef7a55),
  part of the development cycle of version 1.10)

The best experience of Julia on A64FX can be achieved with version 1.9 or following, which
include [important
improvement](https://community.arm.com/arm-community-blogs/b/tools-software-ides-blog/posts/llvm-14)
brough by ARM engineers to LLVM 14 in terms of vectorisation and use of SVE instructions.
For this reason we recommend using the module `julia/nightly-5da8d5f17a` or any other future
module providing Julia v1.9+.

## MPI

You can interface MPI libraries using the Julia package
[`MPI.jl`](https://github.com/JuliaParallel/MPI.jl).  We recommend using v0.20+ of this
package.  Ookami currently provides [two MPI
libraries](https://www.stonybrook.edu/commcms/ookami/support/faq/core-thread-control-mpi-flags.php),
OpenMPI and Mvapich2.  To tell `MPI.jl` to use the system library you have to use the
[`MPIPreferences.use_system_binary()`](https://juliaparallel.org/MPI.jl/stable/reference/mpipreferences/#MPIPreferences.use_system_binary),
see the [configuration
documentation](https://juliaparallel.org/MPI.jl/stable/configuration/) for more details.

To install these packages from the Julia REPL type `]` to enter the Pkg REPL mode and run
the command

```
add MPI MPIPreferences
```

and then press `backspace` to go back to the regular Julia REPL.  After this, you can
configure `MPI.jl` to use system MPI libraries.

### Using OpenMPI

```console
$ module purge # Clean up already loaded modules
Unloading shared
  WARNING: Did not unuse /cm/shared/modulefiles
$ module load openmpi/llvm14/4.1.4 # Load OpenMPI
Loading openmpi/llvm14/4.1.4
  Loading requirement: llvm/14.0.6 ucx/llvm14/1.11.2
$ module load julia/nightly-5da8d5f17a # Load Julia module
$ julia --project -q
julia> using MPIPreferences

julia> MPIPreferences.use_system_binary()
┌ Info: MPI implementation identified
│   libmpi = "libmpi"
│   version_string = "Open MPI v4.1.4, package: Open MPI decarlson@fj-debug1 Distribution, ident: 4.1.4, repo rev: v4.1.4, May 26, 2022\0"
│   impl = "OpenMPI"
│   version = v"4.1.4"
└   abi = "OpenMPI"
┌ Info: MPIPreferences changed
│   binary = "system"
│   libmpi = "libmpi"
│   abi = "OpenMPI"
└   mpiexec = "mpiexec"
```
After restarting Julia:
```julia
julia> using MPI

julia> MPI.MPI_LIBRARY
"OpenMPI"

julia> MPI.MPI_LIBRARY_VERSION
v"4.1.4"

julia> MPI.MPI_LIBRARY_VERSION_STRING
"Open MPI v4.1.4, package: Open MPI decarlson@fj-debug1 Distribution, ident: 4.1.4, repo rev: v4.1.4, May 26, 2022\0"

julia> MPI.Init()
MPI.ThreadLevel(2)

julia> MPI.Get_processor_name()
"fj-debug2"
```

### Using Mvapich2

```console
$ module purge # Clean up already loaded modules
$ module load slurm mvapich2/gcc11/2.3.6
Loading mvapich2/gcc11/2.3.6
  Loading requirement: gcc/11.1.0
$ module load julia/nightly-5da8d5f17a # Load Julia module
$ julia --project -q
julia> using MPIPreferences

julia> MPIPreferences.use_system_binary(; mpiexec="srun") # Mvapich2 uses Slurm, we need to specify that the launcher is `srun`
┌ Info: MPI implementation identified
│   libmpi = "libmpi"
│   version_string = "MVAPICH2 Version      :\t2.3.6\nMVAPICH2 Release date :\tMon March 29 22:00:00 EST 2021\nMVAPICH2 Device       :\tch3:mrail\nMVAPICH2 configure    :\t--prefix=/lustre/software/mvapich2/gcc11/2.3.6 --with-knem=/opt/knem-1.1.3.90mlnx1 --with-hcoll=/opt/mellanox/hcoll --enable-fortran=all --enable-cxx --with-file-system=lustre --with-slurm=/cm/shared/apps/slurm/current --with-pm=slurm --with-pmi=pmi1 --with-device=ch3:mrail --with-rdma=gen2\nMVAPICH2 CC           :\tgcc    -DNDEBUG -DNVALGRIND -O2\nMVAPICH2 CXX          :\tg++   -DNDEBUG -DNVALGRIND -O2\nMVAPICH2 F77          :\tgfortran -fallow-argument-mismatch  -O2\nMVAPICH2 FC           :\tgfortran   -O2\n"
│   impl = "MVAPICH"
│   version = v"2.3.6"
└   abi = "MPICH"
┌ Info: MPIPreferences changed
│   binary = "system"
│   libmpi = "libmpi"
│   abi = "MPICH"
└   mpiexec = "srun"
```
After restarting Julia:
```julia
julia> using MPI

julia> MPI.MPI_LIBRARY
"MVAPICH"

julia> MPI.MPI_LIBRARY_VERSION
v"2.3.6"

julia> MPI.MPI_LIBRARY_VERSION_STRING
"MVAPICH2 Version      :\t2.3.6\nMVAPICH2 Release date :\tMon March 29 22:00:00 EST 2021\nMVAPICH2 Device       :\tch3:mrail\nMVAPICH2 configure    :\t--prefix=/lustre/software/mvapich2/gcc11/2.3.6 --with-knem=/opt/knem-1.1.3.90mlnx1 --with-hcoll=/opt/mellanox/hcoll --enable-fortran=all --enable-cxx --with-file-system=lustre --with-slurm=/cm/shared/apps/slurm/current --with-pm=slurm --with-pmi=pmi1 --with-device=ch3:mrail --with-rdma=gen2\nMVAPICH2 CC           :\tgcc    -DNDEBUG -DNVALGRIND -O2\nMVAPICH2 CXX          :\tg++   -DNDEBUG -DNVALGRIND -O2\nMVAPICH2 F77          :\tgfortran -fallow-argument-mismatch  -O2\nMVAPICH2 FC           :\tgfortran   -O2\n"

julia> MPI.Init()
[fj-debug2:mpi_rank_0][MPID_Init] [Performance Suggestion]: Application has requested for multi-thread capability. If allocating memory from different pthreads/OpenMP threads, please consider setting MV2_USE_ALIGNED_ALLOC=1 for improved performance.
Use MV2_USE_THREAD_WARNING=0 to suppress this error message.
┌ Warning: MPI thread level requested = MPI.ThreadLevel(2), provided = MPI.ThreadLevel(0)
└ @ MPI ~/.julia/packages/MPI/tJjHF/src/environment.jl:96
MPI.ThreadLevel(0)

julia> MPI.Get_processor_name()
"fj-debug2"
```
