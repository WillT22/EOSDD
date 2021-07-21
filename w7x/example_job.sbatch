#!/bin/bash
#SBATCH -n 16
#SBATCH -p general
#SBATCH -t 00:20:00
#SBATCH --mem-per-cpu=2gb
#SBATCH -J example
#SBATCH -o example-%j.out
#SBATCH -e example-%j.err

module load mod_stellopt
module load stellopt

mpirun -np 16 xfieldlines # complete call to FIELDLINES here


