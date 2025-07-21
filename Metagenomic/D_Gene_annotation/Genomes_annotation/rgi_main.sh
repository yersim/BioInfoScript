#!/bin/bash

#SBATCH --partition cpu
#SBATCH --job-name rgi_main
#SBATCH --output /scratch/syersin2/Pastobiome_scratch/std_output/%x_%j.out
#SBATCH --error /scratch/syersin2/Pastobiome_scratch/std_output/%x_%j.err
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 1G
#SBATCH --time 01:00:00
#SBATCH --array=1

# Module
module load gcc/12.3.0
module load miniforge3/4.8.3-4-Linux-x86_64

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate /work/FAC/FBM/DMF/pvonaesc/vonasch_lab_general/syersin/RGI/rgi

# Variables
datadir=/scratch/syersin2/Pastobiome_scratch/data/MAGs
outdir=/scratch/syersin2/Pastobiome_scratch/data/MAGs/RGI_out2
dbdir=/work/FAC/FBM/DMF/pvonaesc/vonasch_lab_general/syersin/RGI/CARD_db/

## Array variables
cd ${datadir}
sample_name=$(ls | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/\.fa$//')

cd ${dbdir}

rm -r ${outdir}/${sample_name}
mkdir -p ${outdir}/${sample_name}

rgi main -i ${datadir}/${sample_name}.fa \
    -o ${outdir}/${sample_name}/${sample_name} \
    -t contig \
    -a DIAMOND \
    -n 1 \
    --local \
    --clean \
    --low_quality \
     --include_nudge
