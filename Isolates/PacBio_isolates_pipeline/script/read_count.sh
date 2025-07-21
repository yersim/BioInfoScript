#!/bin/bash

###------------------
##SLURM options
###------------------
#SBATCH --partition cpu
#SBATCH --job-name readCount
#SBATCH --output /scratch/syersin2/%x_%j.out
#SBATCH --error /scratch/syersin2/%x_%j.err
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 1G
#SBATCH --time 00:05:00

cd ~/test_dir/output_pacbio/filtered_reads/

for file in *.fastq.gz
do
zgrep -c '@m64' $file >> READS_COUNT_filtered.txt
done