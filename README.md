Run all commands from the main directory

1. Preformatting S. fontinalis 
File 'batch1.fa' can be downloaded from `*.com`
Put the file 'batch1.fa' in 00_resources/

1. Remove the newline character to put all on same line

``perl -pe 's/]\n/]\t/g' batch1.fa > 00_resources/batch1_formatted.fa``

2. Run the following R script to retain a single allele 0 record per marker

'01_scripts/01_Sfon_marker_prep.R'

This will produce the file '02_raw_data/sutherland_etal-GBS_loci_complete.txt'

3. Collect all of the online files used in the manuscript as listed in 

`00_resources/data_sources.md` 

and put the downloaded files in 02_raw_data/

4. Use the following R script to format all of the different downloaded genetic maps (from step 2 and 3 above) to prepare for MapCom

``02_map_collect_and_format.R``

Then run the following to move the prepared output files:
``mv *_merged_sorted_clean.csv 02_raw_data/          02_merged_sorted_clean/


5. Clean the final merged data and concatenate 

```
sed 's/\"//g' 02_raw_data/02_merged_sorted_clean/*merged_sorted_clean.csv > 02_raw_data/all_species.csv 
```

This final file is used to input into the next R script

6. Run the following R script

7. Translate the .csv file to .fasta file 

```
awk -F, 'BEGIN{OFS="";} {print $1"_"$2"_"$3"_"$4"_"$5"\n"$6}' 02_raw_data/*_totpos.csv > 03_prepared_data/all_species_w_totpos.fasta

```

# fasta record name will be in this order: sp_lg_pos_totpos_mname

# this file will be used as input to MapComp
