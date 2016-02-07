## Prepare data from published salmonid maps ##
Run all commands from the main directory

### 1. Collect linkage maps used in analysis ###
a) Follow instructions in the `00_resources/data_sources.md` to collect published map data used in manuscript. Save input files to `02_raw_data/`  


### 2. Format all downloaded genetic maps to prepare for MapComp ###

Change working directory in R script 02_raw_data/02_formatting_collected_data/

* Format data in R

```
R -q -e 'source("01_scripts/02_map_collect_and_format.R")'

```

* Move prepared files to new directory

```
mv ./02_raw_data/02_formatting_collected_data/*_merged_sorted_clean.csv 03_prepared_data 

```

* Minor cleaning and concatenate all datafiles  

```
sed 's/\"//g' 03_prepared_data/*merged_sorted_clean.csv > 03_prepared_data/all_species.csv 

```

Now move with the .csv to find total position step of MapComp, and will be ready to compare the salmonid maps.
