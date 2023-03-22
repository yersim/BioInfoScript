#ANALYSIS AND GENERATION OF BACTERIAL PROPORTION IN EACH SAMPLE
#Create an input directory under the metaphlan repository as: /metaphlan/input, and place your input files under it.

# https://github.com/biobakery/biobakery/wiki/metaphlan3

#Basic usage:



mkdir METAPHLAN_ANALYSIS/
#mkdir METAPHLAN_ANALYSIS/PROFILES_STANDARD/
#mkdir METAPHLAN_ANALYSIS/PROFILES_BIOM/
#mkdir METAPHLAN_ANALYSIS/BOWTIE_OUT/
for prefix in $(ls *.fastq.gz | sed -E 's/_FASTP_R[12]_001[.]fastq.gz//' | uniq)
do
    echo "Performing metaphlan3 analysis on sample": "${prefix}_FASTP_R1_001.fastq.gz"
    metaphlan "${prefix}_FASTP_R1_001.fastq.gz" --nproc 26 --add_viruses --input_type fastq -o METAPHLAN_ANALYSIS/${file}_metaphlan3_abundance.txt --no_map
done



#To merge the profiled samples to put them all together :

merge_metaphlan_tables.py METAPHLAN_ANALYSIS/*_metaphlan3_abundance.txt > METAPHLAN_ANALYSIS/JOHI_merged_abundance_table.txt
#merge_metaphlan_tables.py METAPHLAN_ANALYSIS/PROFILES_BIOM/*_metaphlan3_profile_BIOM.txt > METAPHLAN_ANALYSIS/PROFILES_BIOM/merged_abundance_table_BIOM.txt



# To generate the UniFrac distance matrix, you need to run the script as below:
# Need to find the script calculate_unifrac.R and the .nwk tree
# https://github.com/biobakery/MetaPhlAn/blob/master/metaphlan/utils/

# Rscript calculate_unifrac.R merged_abundance_table.txt mpa_v30_CHOCOPhlAn_201901_species_tree.nwk unifrac_merged_abundance_table.tsv





#Heatmap Visualization
# https://github.com/biobakery/biobakery/wiki/metaphlan3

# conda install -c biobakery hclust2

# The hclust2 script generates a hierarchically-clustered heatmap from MetaPhlAn abundance profiles. 
# To generate the heatmap for a merged MetaPhlAn output table (as described above), you need to run the script as below:



# FOr the heatmap, we have to genrate abundance tables for only one taxonomic level at a time (ex: only species)

 # Ex: grep -E "s__|clade" merged_abundance_table.txt | sed 's/^.*s__//g'\ | cut -f1,3-8 | sed -e 's/clade_name/body_site/g' > merged_abundance_table_species.txt

# Then ex:
# hclust2.py -i merged_abundance_table_species.txt -o abundance_heatmap_species.png --f_dist_f braycurtis --s_dist_f braycurtis --cell_aspect_ratio 0.5 -l --flabel_size 10 --slabel_size 10 --max_flabel_len 100 --max_slabel_len 100 --minv 0.1 --dpi 300




#GENERATING GRAPHLAN TREES

# https://github.com/biobakery/biobakery/wiki/metaphlan3



