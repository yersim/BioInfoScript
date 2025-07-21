#!/bin/bash -l

#SBATCH --partition cpu
#SBATCH --job-name trimming
#SBATCH --output /scratch/syersin2/mags_scratch/std_output/%x_%j.out
#SBATCH --error /scratch/syersin2/mags_scratch/std_output/%x_%j.err
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 8
#SBATCH --mem 4G
#SBATCH --time 00:30:00

## Load modules
module load fastp/0.23.2

## Variables
fastp_workdir=/scratch/syersin2/mags_scratch
fastp_indir=/scratch/syersin2/mags_scratch/data
fastp_outdir=/scratch/syersin2/mags_scratch/output_data/fastp
fastp_report_outdir=/users/syersin2/mags_test/data_analysis

## Array variables
cd ${fastp_indir}
sample_name=$(ls | sed -n ${SLURM_ARRAY_TASK_ID}p)
cd ${fastp_workdir}

## Create directory
rm -r ${fastp_workdir}/output_data/fastp
mkdir -p ${fastp_outdir}/${sample_name}_FASTP
mkdir -p ${fastp_report_outdir}/REPORT_FASTP

## Run FastP
fastp -i ${fastp_indir}/${sample_name}/${sample_name}_R1_001.fastq.gz \
    -I ${fastp_indir}/${sample_name}/${sample_name}_R2_001.fastq.gz \
    -o ${fastp_outdir}/${sample_name}_FASTP/${sample_name}_FASTP_R1_001.fastq.gz \
    -O ${fastp_outdir}/${sample_name}_FASTP/${sample_name}_FASTP_R2_001.fastq.gz \
    --report_title "${sample_name}_FASTP_report" \
    -j ${fastp_report_outdir}/${sample_name}_FASTP.json \
    -h ${fastp_report_outdir}/${sample_name}_FASTP.html
