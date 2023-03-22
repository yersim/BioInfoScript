#Install via conda
#(Optionally) Create a new conda environment for the installation
#conda create --name biobakery3 python=3.7
#conda activate biobakery3
#(If you haven't already) Set conda channel priority:
#conda config --add channels defaults
#conda config --add channels bioconda
#conda config --add channels conda-forge
#conda config --add channels biobakery


#Install HUMAnN 3.0 software with demo databases:
#conda install humann -c biobakery
#Conda-installing HUMAnN 3.0 will automatically install MetaPhlAn 3.0.
#To install only MetaPhlAn 3.0 execute:
#conda install metaphlan -c bioconda.


#Upgrading your databases
#The HUMAnN installation comes with small sequence and annotation databases for testing/tutorial purposes.
#To upgrade your pangenome database:
#humann_databases --download chocophlan full /home/wslnx/humann_databases --update-config yes
#To upgrade your protein database:
#humann_databases --download uniref uniref90_diamond /home/wslnx/humann_databases --update-config yes
#To upgrade your annotations database:
#humann_databases --download utility_mapping full /home/wslnx/humann_databases --update-config yes




# Based on : https://github.com/biobakery/biobakery/wiki/humann3

# Create synlinks for test analysis

#ln -s ../*.fastq.gz .


for prefix in $(ls *.fastq.gz | sed -E 's/_FASTP_R[12]_001[.]fastq.gz//' | uniq)
do
	echo "Humann analysis on sample": "${prefix}_FASTP_R1_001.fastq.gz"
	humann -i "${prefix}_FASTP_R1_001.fastq.gz" --threads 26 --output-basename "${prefix}" -o HUMANN_OUTPUT_JOHI_SUBSET --output-max-decimals 2 --remove-temp-output --o-log HUMANN_OUTPUT_JOHI_SUBSET/"${prefix}".log --taxonomic-profile JOHI_merged_abundance_table.txt
done




#Note :
# When analyzing less-well-characterized metagenomes,
# we recommend using a UniRef50-based HUMAnN workflow rather than the default UniRef90-based workflow.



#combining results

#humann_join_tables -i hmp_subset -o hmp_subset_genefamilies.tsv --file_name genefamilies

# Normalizing to control for different sequencing depth across the samples.

#humann_renorm_table -i hmp_subset_genefamilies.tsv -o hmp_subset_genefamilies-cpm.tsv --units cpm






#HUMAnN includes a utility humann_barplot to assist with visualizing stratified outputs. Let's use this tool to make a plot of the differentially abundant pathway we identified above:

#humann_barplot --input hmp_pathabund.pcl --focal-metadata STSite --last-metadata STSite --output plot1.png --focal-feature METSYN-PWY 
