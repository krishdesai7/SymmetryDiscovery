#!/bin/bash
#SBATCH --time=240
#SBATCH --constraint=gpu
#SBATCH --gpus=1
#SBATCH --account=m1759
#SBATCH --dependency=singleton
#SBATCH --mail-user=mail-user=krish.desai@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --output fO2data.txt
conda activate DCTR_gpu
srun -n 1 -c 4 python /global/u1/k/kdesai/SymmetryDiscovery/SymmetryGAN/fO2.ipynb