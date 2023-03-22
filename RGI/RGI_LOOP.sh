# RGI loop for metagenomic short reads or genomic short reads

mkdir RGI_ANALYSIS

echo "========Loading CARD reference data======="
rgi clean --local
wget https://card.mcmaster.ca/latest/data
tar -xvf data ./card.json

echo "======Loading into local directory======"
rgi load --card_json ./card.json --local

echo "======CARD Canonical annotations======"
# Adjust version number
rgi card_annotation -i ./card.json > card_annotation.log 2>&1

ech "======Versions======"
rm card_database_v*_all.fasta
data_version=`echo card_database_v*.fasta | sed 's/.*card_database_v\(.*\).fasta/\1/'`
echo "$cmd data_version: $data_version"

echo "======Load databse======"
rgi load -i ./card.json --card_annotation card_database_v${data_version}.fasta --local

echo "====== Loop ======"

for prefix in $(ls *.fastq.gz | sed -E 's/_FASTP_R[12]_001[.]fastq.gz//' | uniq)
  do
    echo "======Analyze RGI of " "${prefix}" "======"
    rgi bwt -1 ${prefix}_FASTP_R1_001.fastq.gz -2 ${prefix}_FASTP_R2_001.fastq.gz -n 36 -o RGI_ANALYSIS/${prefix}_output --clean --local
    echo "======" "${prefix}" " is done======"
  done

