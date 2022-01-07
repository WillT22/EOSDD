#!/bin/bash
#SBATCH -n 16
#SBATCH -p general
#SBATCH -t 8:00:00
#SBATCH --mem-per-cpu=2gb
#SBATCH -J Theta
#SBATCH -o Theta-%j.out
#SBATCH -e Theta-%j.err

module load anaconda3

mpirun -np 16 python theta_coordinate.py

