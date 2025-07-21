#!/bin/bash

#SBATCH --partition cpu
#SBATCH --job-name rgi
#SBATCH --output /scratch/syersin2/Pastobiome_scratch/std_output/%x_%j.out
#SBATCH --error /scratch/syersin2/Pastobiome_scratch/std_output/%x_%j.err
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 24
#SBATCH --mem 80G
#SBATCH --time 08:00:00
#SBATCH --array=2-3

# Module
module load gcc/12.3.0
module load miniforge3/4.8.3-4-Linux-x86_64

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate /work/FAC/FBM/DMF/pvonaesc/vonasch_lab_general/syersin/RGI/rgi

# Variables
datadir=/scratch/syersin2/Pastobiome_scratch/data/bw_cleaned_reads
outdir=/scratch/syersin2/Pastobiome_scratch/data/RGI_out
dbdir=/work/FAC/FBM/DMF/pvonaesc/vonasch_lab_general/syersin/RGI/CARD_db/

## Array variables
cd ${datadir}
sample_name=$(ls | sed -n ${SLURM_ARRAY_TASK_ID}p)

cd ${dbdir}

rm -r ${outdir}/${sample_name}
mkdir -p ${outdir}/${sample_name}

echo "#####################################################"
echo $id " Start time : $(date -u)"
echo "#####################################################"

rgi bwt -1 ${datadir}/${sample_name}/${sample_name}_bowtie2_R1_001.fastq.gz \
    -2 ${datadir}/${sample_name}/${sample_name}_bowtie2_R2_001.fastq.gz \
    -a kma \
    -n 24 \
    -o ${outdir}/${sample_name}/${sample_name} \
    --clean \
    --local \
    --include_wildcard \

echo "#####################################################"
echo $id " End time : $(date -u)"
echo "#####################################################"