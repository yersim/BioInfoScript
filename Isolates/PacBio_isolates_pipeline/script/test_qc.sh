#!/bin/bash

###------------------
##SLURM options
###------------------
#SBATCH --partition cpu
#SBATCH --job-name testing_qc
#SBATCH --output /scratch/syersin2/%x_%j.out #give a automatic name in link with input
#SBATCH --error /scratch/syersin2/%x_%j.err
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 8G
#SBATCH --time 00:15:00
#SBATCH --array=1-6

##LOAD MODULE
module load gcc/10.4.0
module load fastqc/0.11.9

## SLURM VARIABLE
cd ~/test_dir/data/
INPUTS=$(ls *.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p)

##RUN
mkdir QC
fastqc -o QC/ ${INPUTS}