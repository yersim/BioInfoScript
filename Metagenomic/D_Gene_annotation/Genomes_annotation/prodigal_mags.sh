#!/bin/bash

#SBATCH --partition cpu
#SBATCH --job-name prodigal
#SBATCH --output /scratch/syersin2/Afribiota_scratch/std_output/%x_%j.out
#SBATCH --error /scratch/syersin2/Afribiota_scratch/std_output/%x_%j.err
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 1G
#SBATCH --time 00:15:00
#SBATCH --array=1-45

# Module
module load gcc/12.3.0
module load prodigal/2.6.3

## Variables
indir=/scratch/syersin2/Afribiota_scratch/mags_strep
outdir=/scratch/syersin2/Afribiota_scratch/prodigal

cd ${indir}
mags_name=$(ls | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/.fa$//')

rm -r ${outdir}/${mags_name}
mkdir -p ${outdir}/${mags_name}

prodigal -a ${outdir}/${mags_name}/${mags_name}.faa \
    -f gff \
    -i  ${indir}/${mags_name}.fa \
    -d ${outdir}/${mags_name}/${mags_name}.fna \
    -o ${outdir}/${mags_name}/${mags_name}.gff \
    -c -q \
    -p single