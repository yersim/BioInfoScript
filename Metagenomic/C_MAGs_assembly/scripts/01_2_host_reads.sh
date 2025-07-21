#!/bin/bash -l

#SBATCH --partition cpu
#SBATCH --job-name trimming
#SBATCH --output /scratch/syersin2/mags_scratch/std_output/%x_%j.out
#SBATCH --error /scratch/syersin2/mags_scratch/std_output/%x_%j.err
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 8
#SBATCH --mem 8G
#SBATCH --time 04:00:00

## Load modules
module load gcc/10.4.0
module load bowtie2/2.4.2

## Variables
bwt_workdir=/scratch/syersin2/mags_scratch
bwt_indir=/scratch/syersin2/mags_scratch/output_data/fastp
bwt_outdir=/scratch/syersin2/mags_scratch/output_data/bowtie

## Array variables
cd ${bwt_indir}
sample_name=$(ls | sed -n ${SLURM_ARRAY_TASK_ID}p)
cd ${bwt_workdir}

## Create directory
rm -r ${bwt_workdir}/output_data/bowtie
mkdir -p ${bwt_outdir}/${sample_name}_BOWTIE2

## Run bowtie2 for host read removal
bowtie2  --very-sensitive-local \
    --un-conc-gz ${bwt_outdir}/${sample_name}_BOWTIE2/${sample_name}_BOWTIE2_R%_001.fastq.gz \
	-x /work/FAC/FBM/DMF/pvonaesc/vonasch_lab_general/syersin/Bowtie2/human_index/GRCh38_latest_genomic.INDEX \
	-1 ${sample_name}_R1_001.fastq.gz \
    -2 ${sample_name}_R2_001.fastq.gz \
	-S ${bwt_outdir}/${sample_name}_BOWTIE2/${sample_name}_GRCh38_latest_genomic.sam \
	2>${bwt_outdir}/${sample_name}_BOWTIE2/${sample_name}_GRCh38_latest_genomic_BOWTIE2.log

## Cleaning files
rm ${bwt_outdir}/${sample_name}_BOWTIE2/${sample_name}_GRCh38_latest_genomic.sam