#!/bin/bash

#SBATCH --partition cpu
#SBATCH --job-name prokka
#SBATCH --output /users/syersin2/test_dir/std_output/%x_%j.out
#SBATCH --error /users/syersin2/test_dir/std_output/%x_%j.err
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 8
#SBATCH --mem 10G
#SBATCH --time 08:00:00
#SBATCH --array=1-4

# Module
module load gcc/10.4.0
module load prokka/1.14.6
module load blast-plus/2.12.0

# Prokka is a software tool to annotate bacterial, archaeal and viral genomes quickly and produce standards-compliant output files.

## Variables
prokka_workdir=/users/syersin2/test_dir/comp_genomics
prokka_indir=/users/syersin2/test_dir/comp_genomics/genomes/genomesFASTA
prokka_outdir=/users/syersin2/test_dir/comp_genomics/annotations/prokka
cd ${prokka_indir}
sample_name=$(ls *.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p)
cd ${prokka_workdir}

## Clean output directory
rm -r ${prokka_workdir}/annotations/prokka
#mkdir -p ${prokka_workdir}/annotations/prokka/${sample_name}_PROKKA

## Run prokka
prokka --outdir ${prokka_outdir}/${sample_name}_PROKKA --prefix ${sample_name}_PROKKA ${prokka_indir}/${sample_name} --dbdir /work/FAC/FBM/DMF/pvonaesc/vonasch_lab_general/syersin/Prokka/db

echo "#####################################################"
echo $id " Finishing time : $(date -u)"
echo "#####################################################"