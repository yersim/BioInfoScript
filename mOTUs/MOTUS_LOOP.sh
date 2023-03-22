
# I should try to see what happens if I generate the profiles and output in BIOM format. Would be easier to combine results 
# obtained by metaplhan and motus?

#mkdir MOTUS_ANALYSIS
#mkdir MOTUS_ANALYSIS/MOTUS_MERGE
for level in $(cat LEVEL_LIST.txt)
do
  #mkdir MOTUS_ANALYSIS/MOTUS_${level}_ABOND
  #mkdir MOTUS_ANALYSIS/MOTUS_${level}_READS


  #for prefix in $(ls *.fastq.gz | sed -E 's/_R[12]_001[.]fastq.gz//' | uniq)
  #do
   # echo "Analyses abondance du" "${prefix}" "au niveau" "${level}"
    #motus profile -s ${prefix}_R1_001.fastq.gz -t 38 -o MOTUS_ANALYSIS/MOTUS_${level}_ABOND/${prefix}_${level}_ABOND.motus -n ${prefix}_ABOND -k ${level} -p -q
    #echo "Comptage de reads du" "${prefix}" "au niveau" "${level}"
    #motus profile -s ${prefix}_R1_001.fastq.gz -t 12 -o MOTUS_ANALYSIS/MOTUS_${level}_READS/${prefix}_${level}_READS.motus -n ${prefix}_READS -k ${level} -p -q -c 
    #echo "Tes fichiers récapitulatif sont prêts"
  #done
  motus merge -d MOTUS_ANALYSIS/MOTUS_${level}_ABOND -o MOTUS_ANALYSIS/MOTUS_MERGE/${level}_MERGE_ABONDsim.csv
  #motus merge -d MOTUS_ANALYSIS/MOTUS_${level}_READS -o MOTUS_ANALYSIS/MOTUS_MERGE/${level}_MERGE_READS.motus
done
   
