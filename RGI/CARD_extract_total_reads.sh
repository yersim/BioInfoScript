
# Command line to extract the total reads number from the CARD's rig file "overall mapping stats"
# Merge the total reads of each samples 

mkdir Total_reads


 for prefix in $(ls *_output.overall_mapping_stats.txt | sed -E 's/_output.overall_mapping_stats.txt//')
  do
   	echo "Extract total reads of" "${prefix}" "sample"
    	sed -n 6p "$prefix"_output.overall_mapping_stats.txt > Total_reads/"$prefix"_total_reads.txt
done

cd Total_reads

for prefix in $(ls *_total_reads.txt | sed -E 's/_total_reads.txt//')
  do
  	echo "Add row with sample ID:" "${prefix}"
	sed -i '' -e "1s/^//p;" "$prefix"_total_reads.txt
	sed -i '' -e "1s/.*/$prefix\t/g" "$prefix"_total_reads.txt
done

cat *_total_reads.txt >> Merged_total_reads.txt
