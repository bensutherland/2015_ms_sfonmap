# Developed by Thierry Gosselin and Ben Sutherland from the Bernatchez lab at U. Laval, Quebec
# Prepares S. fontinalis data from the full .fasta off all individuals used in genetic mapping

# rm(list=ls())

# Set working directory to the main directory of the repo

##### Collect data for Sfon map ####
## Only retain a sequence individual's allele 0 per marker
input.file = "00_resources/batch1_formatted.fa"

# Load necessary libraries
library(reshape2)
library(stringr)
library(stringi)
library(plyr)
library(dplyr) # load this package after plyr to work properly
library(tidyr)
library(readr)

# get a unique list of fasta sequences..

system.time(
  unique.locus.fasta <- read_tsv(
    file = input.file, 
    progress = interactive(),
    col_names = c("ID", "seq")
  ) %>% 
    separate(ID, c("mname", "ALLELE"), sep = "_Sample_", extra = "error" ) %>% 
    mutate(mname = stri_replace_all_fixed(mname, pattern = ">CLocus_", replacement = "", vectorize_all = FALSE)) %>% 
    separate(ALLELE, c("JUNK", "ALLELE_ID"), sep = "_Allele_", extra = "error" ) %>%
    select(-JUNK) %>% 
    separate(ALLELE_ID, c("ALLELE_ID", "JUNK"), sep = " ", extra = "error" ) %>%
    select(-JUNK) %>%
    filter(ALLELE_ID == "0") %>%
    select(-ALLELE_ID) %>% 
    distinct(mname)
)

dim(unique.locus.fasta)
unique.locus.fasta[1:2,1:2]

write.table(unique.locus.fasta, file =  "02_raw_data/sutherland_etal-GBS_loci_complete.txt", sep = "\t", row.names = F, col.names = T, quote = F)