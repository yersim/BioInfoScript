## ShortBRED for Antibiotic Resistance Gene using CARD db and Uniref90 db

#Install via conda
#(Optionally) Create a new conda environment for the installation
#conda create --name shortbred
#conda activate shortbred

#Install shortbred software with demo databases:
#conda install -c biobakery shortbred

# Download and extract in a folder:
# https://github.com/biobakery/shortbred/archive/0.9.4.zip

# Download USEARCH 32 bit for your computer (LINUX OR MACOS)
# https://www.drive5.com/usearch/download.html
# Save it the same folder than shortBRED

#Download databases
#CARD database: https://card.mcmaster.ca/download
# CARD db contains the protein of interest 
# Uniref database:  https://ftp.expasy.org/databases/uniprot/current_release/uniref/uniref90/
# Uniref90 db contains the reference set of proteins

# Based on : https://github.com/biobakery/shortbred

#Create synlinks for test analysis

#ln -s ../*.fastq.gz .


# 1. Create a new markers set with shortbred identify
./shortbred_identify.py --goi CARD_db.faa --ref uniref90_db.faa --markers mymarkers.faa --tmp example_identify --threds 36


# 2. Profile a whole genome samples
# For 1 file:
# ./shortbred_quantify.py -markers mymarkers.faa --wgs seqfile.fna --results myresults.txt --tmp example_quanitfy

# Loop for multiple files:
for prefix in $(ls *.fastq.gz | sed -E 's/_R[12]_001[.]fastq.gz//' | uniq)
do
	echo "Shortbred analysis on sample": "${prefix}_R1_001.fastq.gz"
	./shortbred_quantify.py -markers mymarkers.faa --wgs "${prefix}_R1_001.fna" --results "${prefix}"_shortbred.txt --tmp "${prefix}"_example_quanitfy
done

# Merge table, see CARD RGI merging table script and adapt it 