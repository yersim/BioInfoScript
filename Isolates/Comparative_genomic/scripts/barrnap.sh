#!/bin/bash

#SBATCH --job-name barrnap
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 2G
#SBATCH --time 1:00:00
#SBATCH --output /users/syersin2/test_dir/std_output/%x_%j.out
#SBATCH --error /users/syersin2/test_dir/std_output/%x_%j.err
#SBATCH --array=1-4

module load gcc/10.4.0
module load perl/5.34.1
module load barrnap/0.8
module load bedtools2/2.30.0
module load samtools/1.15.1

# Set variables
barrnap_workdir=/users/syersin2/test_dir/comp_genomics
barrnap_indir=/users/syersin2/test_dir/comp_genomics/genomes/genomesFASTA
cd ${barrnap_indir}
sample_name=$(ls *.fasta | sed -n ${SLURM_ARRAY_TASK_ID}p)
cd ${barrnap_workdir}
outputdir=/users/syersin2/test_dir/comp_genomics/QC_Taxonomy/barrnap/${sample_name}_16SrRNA

## Remove existing dir and create new one
rm -r ${barrnap_workdir}/QC_Taxonomy/barrnap
mkdir -p ${barrnap_workdir}/QC_Taxonomy/barrnap/${sample_name}_16SrRNA

## Annotate genomes with barrnap
barrnap ${barrnap_indir}/${sample_name} >${outputdir}/${sample_name}_rRNA_loc.gff

## Extract 16S rRNA gene
gff_inputfile=${outputdir}/${sample_name}_rRNA_loc.gff

grep '16S' ${gff_inputfile} > ${outputdir}/16S-gff.gff
bedtools getfasta -fi ${barrnap_indir}/${sample_name} -bed ${outputdir}/16S-gff.gff -fo ${outputdir}/16S-fasta.fna
grep -m 1 ">" ${outputdir}/16S-fasta.fna|sed 's/>//g' > ${outputdir}/16S-id.txt
xargs samtools faidx ${outputdir}/16S-fasta.fna < ${outputdir}/16S-id.txt > ${outputdir}/${sample_name}_16SrRNA.fasta

#Here we delete some temporary files that were created-
rm ${outputdir}/16S-gff.gff
rm ${outputdir}/16S-fasta.fna
rm ${outputdir}/16S-fasta.fna.fai
rm ${outputdir}/16S-id.txt
rm ${barrnap_indir}/*.fasta.fai

echo "#####################################################"
echo $id " Finishing time : $(date -u)"
echo "#####################################################"