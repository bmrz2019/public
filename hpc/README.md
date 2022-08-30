- `squeue -u`

### Example

```
#!/bin/bash
#SBATCH --partition=parallel
#SBATCH --constraint=water
#SBATCH --time=7-23:59:00
#SBATCH --mail-user=user@example.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=32             # number of nodes allocated for this job
#SBATCH --ntasks=128
##SBATCH --output class2d-nodes_60.log

module load openmpi/gcc/64/1.10.3
export OMP_NUM_THREADS=1
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$HOME/software/relion/lib:/software/relion/external/fftw/lib
export PATH=${PATH}:$HOME/software/relion/bin
export RELION_MOTIONCORR_EXECUTABLE=$HOME/software/relion/bin/relion_run_motioncorr

mkdir 2D_example
date >> 2D_example/START
#srun -n 2 `which relion_refine_mpi` --i Particles/shiny_2sets.star --ctf --iter 25 --tau2_fudge 2 --particle_diameter 360 --K 200 --zero_mask --oversampling 1 --psi_step 6 --offset_range 5 --offset_step 2 --norm --scale --random_seed 0 --o ./class2d
mpirun -n 128 `which relion_refine_mpi` --i ./Particles/shiny_2sets.star --ctf --iter 25 --tau2_fudge 2 --particle_diameter 360 --K 200 --zero_mask --oversampling 1 --psi_step 6 --offset_range 5 --offset_step 2 --norm --scale --random_seed 0 --o ./2D_example/class2d

date >> 2D_example/FINISH
#mpirun -n 128 `which relion_refine_mpi` --i Particles/shiny_2sets.star --ref emd_2660.map:mrc --firstiter_cc --ini_high 60 --ctf --ctf_corrected_ref --iter 25 --tau2_fudge 4 --particle_diameter 360 --K 6 --flatten_solvent --zero_mask --oversampling 1 --healpix_order 2 --offset_range 5 --offset_step 2 --sym C1 --norm --scale --random_seed 0 --o ./water/class3d

```





