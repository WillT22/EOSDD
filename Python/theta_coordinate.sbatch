#!/bin/bash
#SBATCH -n 16
#SBATCH -p general
#SBATCH -t 8:00:00
#SBATCH --mem-per-cpu=2gb
#SBATCH -J Theta_s_t2
#SBATCH -o Theta_s_t2-%j.out
#SBATCH -e Theta_s_t2-%j.err

module load anaconda3

mpirun -np 16 python theta_coordinate.py

