
mkdir Merged_table

mkdir Modified_table 


 for prefix in $(ls *_output.allele_mapping_data.txt | sed -E 's/_output.allele_mapping_data.txt//')
  do
   	echo "Add column in" "${prefix}" "sample"
    	sed "s/^/$prefix\t/g" "$prefix"_output.allele_mapping_data.txt > Modified_table/"$prefix"_allele_mapping.txt
done

cat Modified_table/*_allele_mapping.txt >> Merged_table/Merged_Card_table.txt

head -n 1 Merged_table/Merged_Card_table.txt >> titre.txt

grep -v "Flanking" Merged_table/Merged_Card_table.txt >> Merged_table/Corr_Merged_Card_table.txt

cat titre.txt Merged_table/Corr_Merged_Card_table.txt >> Merged_table/Comp_Merged_Card_table.txt