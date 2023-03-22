
# Loop 

mkdir fastq_files

for level in $(cat SRR_Acc_List.txt)
do
   echo "Prefetching:" "${level}"
   ./prefetch -v "${level}"
   echo "${level}" "prefetched"
   echo "fastq dump for:" "${level}"
   ./fastqer-dump --split-files "${level}" --outdir fastq_files
   echo "${level}" "downloaded"
done