#!/bin/bash

#SBATCH --job-name DRAM
#SBATCH --partition cpu
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 16
#SBATCH --mem 150G
#SBATCH --time 3:00:00
#SBATCH --output /users/syersin2/test_dir/std_output/%x_%j.out
#SBATCH --error /users/syersin2/test_dir/std_output/%x_%j.err

# Module
module load gcc/10.4.0
module load miniconda3/4.10.3

# Activate conda environment
eval "$(conda shell.bash hook)"
conda activate /work/FAC/FBM/DMF/pvonaesc/vonasch_lab_general/syersin/DRAM/dram

## Variables
dram_workdir=/users/syersin2/test_dir/comp_genomics/annotations/DRAM

# Provide the checkM output to DRAM
checkm_stats=/users/syersin2/test_dir/comp_genomics/QC_Taxonomy/checkM_QC/Checkm_QC_stats.tsv
gtdb_stats=/users/syersin2/test_dir/comp_genomics/QC_Taxonomy/GTDB_out/gtdbtk.bac120.summary.tsv

rm -r ${dram_workdir}
mkdir -p ${dram_workdir}
cd ${dram_workdir}

#Execute DRAM
## Annotate
DRAM.py annotate -i '/users/syersin2/test_dir/comp_genomics/genomes/genomesFASTA/*.fasta' \
    -o dram_annotations \
    --checkm_quality ${checkm_stats} \
    --gtdb_taxonomy ${gtdb_stats} \
    --threads 16
## Distill
DRAM.py distill -i dram_annotations/annotations.tsv \
    -o genome_summaries \
    --trna_path dram_annotations/trnas.tsv \
    --rrna_path dram_annotations/rrnas.tsv