#!/bin/bash

# Load some modules needed to dlopen the shared libraries
module purge
module load gcc/12.2.0
module load llvm/15.0.3
module load fujitsu/compiler/4.7

# Load Julia module
module load julia/nightly-5da8d5f17a

# Compile the shared libraries, if necessary
make

# Start Julia, make sure Pluto is installed and start the server
julia --project=. -e '
import Pkg
Pkg.instantiate()
import Pluto
Pluto.run(; launch_browser=false)
'
