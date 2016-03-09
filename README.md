# Prepare data from published salmonid maps
B Sutherland, Bernatchez Lab, 2016-03-09  
*Run all commands from the main directory*

### 1. Collect raw data to be used
Follow instructions in `00_resources/data_sources.md` to obtain the published map data used in manuscript. After following these instructions, input files should be in `02_raw_data/`  


### 2. Format genetic maps to prepare for MapComp
Change working directory in R script towards your copy of `02_raw_data/02_formatting_collected_data/`  
Then format data in R by using the following script:  

```
R -q -e 'source("01_scripts/02_map_collect_and_format.R")'

```

Then move the formatted files to a 03_prepared_data  

```
mv ./02_raw_data/02_formatting_collected_data/*_merged_sorted_clean.csv 03_prepared_data 

```

Cleaning and concatenate datafiles  

```
sed 's/\"//g' 03_prepared_data/*merged_sorted_clean.csv > 03_prepared_data/all_species.csv 

```

Take the all_species.csv to your MapComp repo in order to find total positions of markers, format to fasta file, then to compare among the maps.  
