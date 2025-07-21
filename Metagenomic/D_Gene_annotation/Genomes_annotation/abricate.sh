#!/bin/bash

#SBATCH --partition cpu
#SBATCH --job-name abricate
#SBATCH --output /scratch/syersin2/Pastobiome_scratch/std_output/%x_%j.out
#SBATCH --error /scratch/syersin2/Pastobiome_scratch/std_output/%x_%j.err
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 200M
#SBATCH --time 01:00:00
#SBATCH --array=1-3

# Module
module load gcc/12.3.0
module load miniforge3/4.8.3-4-Linux-x86_64

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate /work/FAC/FBM/DMF/pvonaesc/vonasch_lab_general/syersin/ABRicate/abricate

# Variables
datadir=/scratch/syersin2/Pastobiome_scratch/data/MAGs
outdir=/scratch/syersin2/Pastobiome_scratch/data/abricate_out

## Array variables
sample_name=$(ls ${datadir} | sed -n ${SLURM_ARRAY_TASK_ID}p | sed 's/\.fa$//')

rm -r ${outdir}/${sample_name}
mkdir -p ${outdir}/${sample_name}

abricate ${datadir}/${sample_name}.fa \
    --db card > ${outdir}/${sample_name}/${sample_name}.card.tab

abricate ${datadir}/${sample_name}.fa \
    --db resfinder > ${outdir}/${sample_name}/${sample_name}.resfinder.tab

abricate ${datadir}/${sample_name}.fa \
    --db argannot > ${outdir}/${sample_name}/${sample_name}.argannot.tab

abricate --summary ${outdir}/${sample_name}/${sample_name}.card.tab \
    ${outdir}/${sample_name}/${sample_name}.resfinder.tab \
    ${outdir}/${sample_name}/${sample_name}.argannot.tab > ${outdir}/${sample_name}/${sample_name}.abricate.tsv

# DATABASE        SEQUENCES       DBTYPE  DATE
# megares 6635    nucl    2025-Jan-14
# resfinder       3077    nucl    2025-Jan-14
# card    2631    nucl    2025-Jan-14
# argannot        2223    nucl    2025-Jan-14
# ecoh    597     nucl    2025-Jan-14
# vfdb    2597    nucl    2025-Jan-14
# plasmidfinder   460     nucl    2025-Jan-14
# ecoli_vf        2701    nucl    2025-Jan-14
# ncbi    5386    nucl    2025-Jan-14

# ABRicate can combine results into a simple matrix of gene presence/absence. 
# An absent gene is denoted . and a present gene is represented by its '%COVERAGE`.