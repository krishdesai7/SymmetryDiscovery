#!/bin/bash
#SBATCH --nodes=2
#SBATCH --time=240
#SBATCH --constraint=gpu
#SBATCH --gpus=16
#SBATCH --ntasks=40
#SBATCH --ntasks-per-node=20
#SBATCH --cpus-per-task=4
#SBATCH --account=m1759
#SBATCH --dependency=singleton
#SBATCH --mail-user=mail-user=krish.desai@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --output fO2data.txt
conda activate DCTR_gpu
srun -n 40 -c 4 python /global/u1/k/kdesai/SymmetryDiscovery/SymmetryGAN/fO2.ipynb