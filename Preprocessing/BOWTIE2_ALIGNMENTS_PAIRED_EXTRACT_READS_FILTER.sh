## First clean up with fastP then with Bowtie2
#!/bin/bash

# Automation of cleaning de reads with fastP

# Table 3: Summary of 1S Plus tail trimming Recommendations
# 15 bases from END of Read1 15 bases from START of Read2

#mkdir CLEANED_READS

# Install fast
# conda install -c bioconda fastp

#for prefix in $(ls *.fastq.gz | sed -E 's/_R[12]_001[.]fastq.gz//' | uniq)
#do
#echo "performing cleaning on files :" "${prefix}_R1_001.fastq.gz" "${prefix}_R2_001.fastq.gz"
#fastp -i "${prefix}_R1_001.fastq.gz" -I "${prefix}_R2_001.fastq.gz" -o CLEANED_READS/"${prefix}_FASTP_R1_001.fastq.gz"  -O CLEANED_READS/"${prefix}_FASTP_R2_001.fastq.gz" --report_title "${prefix}_fastp_report" --thread 10 -j "${prefix}_fastp_report".json -h "${prefix}_fastp_report".html --trim_front1 0 --trim_tail1 15 --trim_front2 20 --trim_tail2 0
#done

#cd ./CLEANED_READS

##### Automation of alignment
# Building of genome index on which we want to align: necessary for Bowtie2
# Put the fasta file that will be used for bowtie index in ./CLEANED_READS

#ASSUMES ZIPPED FILES

# Install bowtie2
# conda install -c bioconda bowtie2

#for file in *.fasta
#do 
#bowtie2-build --threads 10 $file $file.INDEX
#done

mkdir FASTQC_ANALYSIS

for index in *.fasta
do
#Create directory for future file storage
mkdir ${index}.INDEX

	# Loop for alignment of each read PE files on each genome (index)
	for prefix in $(ls *.fastq.gz | sed -E 's/_R[12]_001[.]fastq.gz//' | uniq)
	do
	echo "performing alignment on files :" "${prefix}_R1_001.fastq.gz" "&" "${prefix}_R2_001.fastq.gz" "ON INDEX :" "${index}"
	bowtie2  --very-sensitive-local --un-conc-gz ./"${index}.INDEX/HOST_EXTRACTED_${prefix}_R%_001.fastq.gz" -p 10 -x $index.INDEX -1 "${prefix}_R1_001.fastq.gz" -2 "${prefix}_R2_001.fastq.gz" -S ./"${index}.INDEX"/"${prefix}_${index}.sam" 2>./"${index}.INDEX"/"${prefix}_${index}_BOWTIE2.log"
	rm ./"${index}.INDEX"/"${prefix}_${index}.sam"
	done
fastqc *.fastq.gz -o ./FASTQC_ANALYSIS
fastqc ./"${index}.INDEX"/*.fastq.gz -o ./FASTQC_ANALYSIS
done


multiqc ./FASTQC_ANALYSIS/* --ignore-symlinks --outdir ./FASTQC_ANALYSIS/MULTIQC_FILES --filename ALL_REPORTS_MULTIQC --fullnames --title ALL_REPORTS_MULTIQC

multiqc ./"${index}.INDEX"/* --ignore-symlinks --outdir ./FASTQC_ANALYSIS/MULTIQC_MAPPING_INFOS --filename MULTIQC_MAPPING_INFOS --fullnames --title MULTIQC_MAPPING_INFOS







