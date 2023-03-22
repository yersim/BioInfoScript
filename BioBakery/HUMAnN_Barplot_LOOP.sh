
# Loop to run Humann Barplot on all pathway detected


#mkdir Barplots
mkdir Barplots/log_scale
#mkdir Barplots/linear_scale

for level in $(cat Pathways_humann.txt)
do
   echo "Barplot of pathway" "${level}"
   humann_barplot --input path_abundance_country.txt --focal-metadata Country --last-metadata Country --output Barplots/log_scale/plot_log_${level}.png --focal-feature ${level} --sort sum metadata --scaling logstack
   echo "${level}" "done log scale"
   #humann_barplot --input path_abundance_country.txt --focal-metadata Country --last-metadata Country --output Barplots/linear_scale/plot_lin_${level}.png --focal-feature ${level} --sort sum metadata
   #echo  "${level}" "done linear scale"
done