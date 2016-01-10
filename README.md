## Prepare data from published salmonid maps ##
Run all commands from the main directory

### 1. Collect linkage maps used in analysis ###
a) Follow instructions in the `00_resources/data_sources.md` to collect published map data used in manuscript. Save input files to `02_raw_data/`  

b) Collect data from current paper (*Salvelinus fontinalis*)  

* Download file 'batch1.fa' from `*.com` (*update link*) and put in `00_resources/`

* Pre-format `batch1.fa` into a tab delimited file all on one line by running the following command:

``perl -pe 's/]\n/]\t/g' 00_resources/batch1.fa > 00_resources/batch1_formatted.txt``

### 2. Retain one sequence (allele 0) per marker in 'batch_formatted.txt' ###

```
R -q -e 'source("01_scripts/01_Sfon_marker_prep.R")'

```

This will produce the file '02_raw_data/sutherland_etal-GBS_loci_complete.txt'

### 3. Format all downloaded genetic maps to prepare for MapComp ###

* Format data in R

```
R -q -e 'source("01_scripts/02_map_collect_and_format.R")'

```

* Move prepared files to new directory

```
mv ./*_merged_sorted_clean.csv 02_raw_data/02_merged_sorted_clean/

```

* Minor cleaning and concatenate all datafiles  

```
sed 's/\"//g' 02_raw_data/02_merged_sorted_clean/*merged_sorted_clean.csv > 02_raw_data/all_species.csv 

```

### 4. Find total position within linkage group ### 

Run the following script on `02_raw_data/all_species.csv`

```
R -q -e 'source("01_scripts/03_LG_totpos.R")'

```

### 5. Translate .csv to .fasta 

```
awk -F, 'BEGIN{OFS="";} {print $1"_"$2"_"$3"_"$4"_"$5"\n"$6}' 02_raw_data/*_totpos.csv > 03_prepared_data/all_species_w_totpos.fasta

```

Note: records for fasta will be in this order: sp_lg_pos_totpos_mname

### `all_species_w_totpos.fasta` is the analysis input for MapComp ###