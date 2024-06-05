#!/bin/bash

#SBATCH --job-name=Step-2-SE4HPC  ## Name of the job
#SBATCH --output=output.txt       ## Stdout
#SBATCH --error=error.txt         ## Stderr
#SBATCH --ntasks=1                ## Num tasks
#SBATCH --cpus-per-task=1         ## Num CPU
#SBATCH --time=01:00:00           ## Job Duration

mpirun -n 2 singularity exec MatMultiplication.sif /opt/build_files/build/main
# Export the TMPDIR variable and create the temporary directory
export TMPDIR=$HOME/tmp
mkdir -p $TMPDIR

# Run the Singularity image: srun executes the specified command with the allocated resources
srun singularity exec --bind $TMPDIR:/scratch_local MatMultiplication.sif bash -c "mpirun -np 2 /opt/build_files/build/main"