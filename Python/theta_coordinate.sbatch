#!/bin/bash
#SBATCH -n 16
#SBATCH -p general
#SBATCH -t 8:00:00
#SBATCH --mem-per-cpu=2gb
#SBATCH -J Theta_test2
#SBATCH -o Theta_test2-%j.out
#SBATCH -e Theta_test2-%j.err

module load anaconda3
unset LD_PRELOAD

mpirun -np 16 python theta_coordinate_test.py

