## Preformatting ##
Place the file 'batch1.fa' in the raw data folder

perl -pe 's/]\n/]\t/g' /Users/wayne/Documents/bernatchez/01_Sfon_projects/01_SfQTL/01_genetic_map_and_QTL/03_map_v2/04_fasta_map/batch_1.fa > 00_resources/batch1_formatted.fa



## Select only one sequence for each marker, retaining only allele 0

Requires a fasta file: batch_1.fa
