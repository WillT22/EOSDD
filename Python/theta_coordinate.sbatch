#!/bin/bash
#SBATCH -n 16
#SBATCH -p general
#SBATCH -t 8:00:00
#SBATCH --mem-per-cpu=2gb
#SBATCH -J theta_Cbar_10
#SBATCH -o theta_Cbar_10-%j.out
#SBATCH -e theta_Cbar_10-%j.err

module load anaconda3

mpirun -np 16 python theta_coordinate.py

