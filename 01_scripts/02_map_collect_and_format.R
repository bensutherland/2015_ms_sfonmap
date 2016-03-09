# Format all datafiles to be used by salmonid comparison for MapComp paper 
# 2016-03-09
# Ben Sutherland - Bernatchez lab, U. Laval, Quebec
# Note: before starting, download all input files as stated in 00_resources/data_sources.md 

# rm(list=ls())

library(tidyr)

# Set working directory to the main directory of the repo
# setwd("~/Documents/bernatchez/01_Sfon_projects/01_SfQTL/21_2015_ms_sfonmap/02_raw_data/02_formatting_collected_data")

# For each species, we want the following information (in order):
## >Species  LG  LGcM  totposcM  mname sequence


###### Coho Salmon Okis (Kodama et al 2014) ####
# import map file
Okis_map <- read.csv(file = "kodama_etal2014_map.csv")
colnames(Okis_map) <- c("LG","Marker","cM")
dim(Okis_map) #6643 entries
head(Okis_map)

# import seq file
Okis_seq <- read.csv(file = "kodama_etal2014_seq.csv")[,1:2]
dim(Okis_seq) #52936 records
head(Okis_seq)

# merge seq and map files
Okis_merged <- merge(Okis_map, Okis_seq, by = "Marker")
dim(Okis_merged) #5377 entries
head(Okis_merged)

# sort by chromosome then by map distance
Okis_merged_sorted <- Okis_merged[with(Okis_merged, order(Okis_merged$LG, Okis_merged$cM)), ]
head(Okis_merged_sorted)

# minor cleaning
# clean marker name
Okis_merged_sorted_clean <- 
  separate(data = Okis_merged_sorted, col = "Marker", 
           sep = "_",
           into = c("mname", "extras") 
  )[,-2] # drops the 'extras
head(Okis_merged_sorted_clean)

# clean LG name
Okis_merged_sorted_clean$LG <- gsub(pattern = "Co", replacement = "", x = Okis_merged_sorted_clean$LG)
head(Okis_merged_sorted_clean)

# add extra needed columns
Okis_merged_sorted_clean$species <- rep(x = ">Okis", times = length(Okis_merged_sorted_clean[,1]))
Okis_merged_sorted_clean$cM.null <- rep(x = 0, times = length(Okis_merged_sorted_clean[,1]))

head(Okis_merged_sorted_clean)

# reorder the columns:
Okis_merged_sorted_clean <- Okis_merged_sorted_clean[,c(5,2,3,6,1,4)]
head(Okis_merged_sorted_clean)

# write out:
write.table(Okis_merged_sorted_clean, file = "Okis_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

# end Okis

#
###### Otsh (Brieuc et al 2014) #####
# import map file
Otsh_map <- read.csv(file = "brieuc_etal2014_map.csv")[,1:3]
head(Otsh_map)
# import seq file
Otsh_seq <- read.csv(file = "brieuc_etal2014_seq.csv")
head(Otsh_seq)

# merge seq and map files
Otsh_merged <- merge(Otsh_map, Otsh_seq, by = "Marker")

# sort by chromosome then by map distance
Otsh_merged_sorted <- Otsh_merged[with(Otsh_merged, order(Otsh_merged$Chromosome, Otsh_merged$Distance..cM.)), ]

# minor cleaning
# remove LG name on Marker
Otsh_merged_sorted_clean <- 
  separate(data = Otsh_merged_sorted, col = "Marker", 
              sep = "_",
              into = c("mname", "extras") 
                    )[,-2] # drops the 'extras
head(Otsh_merged_sorted_clean)

# remove LG designation in Chromosome
Otsh_merged_sorted_clean$Chromosome <- gsub(pattern = "Ots", replacement = "", x = Otsh_merged_sorted_clean$Chromosome)
head(Otsh_merged_sorted_clean)

# add extra needed columns
Otsh_merged_sorted_clean$species <- rep(x = ">Otsh", times = length(Otsh_merged_sorted_clean[,1]))
Otsh_merged_sorted_clean$cM.null <- rep(x = 0, times = length(Otsh_merged_sorted_clean[,1]))

head(Otsh_merged_sorted_clean)

# reorder the columns:
Otsh_merged_sorted_clean <- Otsh_merged_sorted_clean[,c(5,2,3,6,1,4)]
head(Otsh_merged_sorted_clean)

# write out:
write.table(Otsh_merged_sorted_clean, file = "Otsh_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

# end Otsh

###### Omyk (Palti et al 2015) ####
# read in map and seq files
Omyk_map <- read.csv(file = "palti_etal2015_map.csv", header = F)
dim(Omyk_map) #1167 markers
head(Omyk_map)
colnames(Omyk_map) = c("LG", "mname", "cM")
Omyk_map$LG <- 
  gsub(pattern = ".csv_marker_and_cM.csv", replacement="", x = Omyk_map$LG, perl = F)
Omyk_map$LG <- 
  gsub(pattern = "SEX", replacement="29", x = Omyk_map$LG, perl = F)
# note here that the 'sex' chromosome is replaced by LG29
Omyk_map$LG <- 
  as.numeric(gsub(pattern = "Omy", replacement="", x = Omyk_map$LG, perl = F))
Omyk_map$LG


Omyk_seq <- read.csv(file = "palti_etal2015_seq.csv", header = T)
dim(Omyk_seq) #5612 markers
head(Omyk_seq)
colnames(Omyk_seq) = c("mname","seq")
head(Omyk_seq)
str(Omyk_seq)
# need to remove [X/X] keep just the second X
Omyk_seq$seq <- 
  gsub(pattern = "\\[[A-Z]/|\\]", replacement="", x = Omyk_seq$seq, perl = T)

# and also fix marker name too
Omyk_seq$mname <- gsub(pattern = "_.*", replace = "", Omyk_seq$mname, perl = T)
head(Omyk_seq) # now all is good.

# merge the files
Omyk_merged <- merge(Omyk_seq, Omyk_map, by = "mname")
dim(Omyk_merged) #955 records
head(Omyk_merged)
Omyk_merged_sorted <- Omyk_merged[with(Omyk_merged, order(Omyk_merged$LG, Omyk_merged$cM)), ]
head(Omyk_merged_sorted)
dim(Omyk_merged_sorted) # only 955 markers for some reason...

# add extra bits
Omyk_merged_sorted$species <- rep(x = ">Omyk", times = length(Omyk_merged_sorted[,1]))
Omyk_merged_sorted$cM.null <- rep(x = 0, times = length(Omyk_merged_sorted[,1]))

# and re-order cols
head(Omyk_merged_sorted)
Omyk_merged_sorted <- Omyk_merged_sorted[,c(5,3,4,6,1,2)]
head(Omyk_merged_sorted)
write.table(Omyk_merged_sorted, file = "Omyk_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")


# import seq file
Oket_seq <- read.csv(file = "waples_etal2015_seq.csv",
                        header = F)
head(Oket_seq)
colnames(Oket_seq) <- c("Marker","Sequence")

# import map file
Oket_map <- read.table(file = "waples_etal2015_map.txt",
                     header = T, sep = "\t")
head(Oket_map)
colnames(Oket_map) <- c("LG", "Marker", "cM")

dim(Oket_map) #5221 records

# minor cleaning to remove '_x1' from Marker
Oket_map$Marker <- gsub(pattern = "_x1", replacement = "", x = Oket_map$Marker)
head(Oket_map)

# minor cleaning to remove '>c' from Marker
Oket_seq$Marker <- gsub(pattern = ">c", replacement = "", x = Oket_seq$Marker)
head(Oket_seq)

# merge seq and map files
Oket_merged <- merge(Oket_seq, Oket_map, by = "Marker")
dim(Oket_merged) #5178 records
head(Oket_merged)

# sort
Oket_merged_sorted <- Oket_merged[with(Oket_merged, order(Oket_merged$LG, Oket_merged$cM)), ]
head(Oket_merged_sorted)

# add extra needed columns
Oket_merged_sorted_clean <- Oket_merged_sorted
Oket_merged_sorted_clean$species <- rep("Oket", times = length(Oket_merged_sorted$Marker))
Oket_merged_sorted_clean$cM.null <- rep(0, times = length(Oket_merged_sorted$Marker))
head(Oket_merged_sorted_clean)

# reorder the columns:
Oket_merged_sorted_clean <- Oket_merged_sorted_clean[,c(5,3,4,6,1,2)]
head(Oket_merged_sorted_clean)

# write out:
write.table(Oket_merged_sorted_clean, file = "Oket_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

# end Oket

###### Oner (Larson et al 2016) ####
# import seq file
Oner_all <- read.csv(file = "larson_etal2015_map_and_seq.csv", header = T)
colnames(Oner_all) <- c("Marker","LG","cM","seq")                     
head(Oner_all)
tail(Oner_all)
dim(Oner_all) #6262 markers
str(Oner_all)

# note there is a So09 and So09.5; this doesn't fit with script, so name it different and place at end
Oner_all$LG <- gsub(pattern = "9.5", replace = as.numeric(max(Oner_all$LG) + 1), Oner_all$LG)
Oner_all$LG <- as.numeric(Oner_all$LG)
Oner_all$species <- rep(x = ">Oner", times = length(Oner_all[,1]))
Oner_all$cM.null <- rep(x = 0, times = length(Oner_all[,1]))
head(Oner_all)

# reorder the columns:
Oner_all <- Oner_all[,c(5,2,3,6,1,4)]
head(Oner_all)

#write out
write.table(Oner_all, file = "Oner_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

###### Sfon (current study) #######
# this file is already formatted and is: additional_fileS2_sfon_female_map.csv


###### Ssal (Lien et al 2011) ####
Ssal_all <- read.csv(file = "lien_etal2011_map_and_seq.csv", header = T)[,c(1,3,5,8)]
head(Ssal_all, n = 1)
names(Ssal_all)
colnames(Ssal_all) <- c("mname", "LG", "cM", "seq")

# remove markers without positions
Ssal_all <- Ssal_all[-is.na(Ssal_all$cM),]
dim(Ssal_all) # 5917 records

# minor cleaning, remove the underscores so they don't get in the way of underscores needed for MapComp
Ssal_all$mname <- gsub(pattern = "_", replace = "-", x = Ssal_all$mname)
head(Ssal_all, n = 1)

# remove LG extra
Ssal_all$LG <- gsub(pattern = "ssa", replace = "", Ssal_all$LG)

# add extra bits
Ssal_all$species <- rep(x = ">Ssal", times = length(Ssal_all[,1]))
Ssal_all$cM.null <- rep(x = 0, times = length(Ssal_all[,1]))

# and re-order cols
head(Ssal_all, n = 1)
Ssal_all <- Ssal_all[,c(5,2,3,6,1,4)]

# write out:
write.table(Ssal_all, file = "Ssal_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")


###### Cclu (Gagnaire et al 2013) ####
# import map and seq file
Cclu_all <- read.csv(file = "gagnaire_etal2013_map_and_seq.csv")[,c(4,2,5,3)]
head(Cclu_all)
dim(Cclu_all)  #3438 markers
colnames(Cclu_all) <- c("LG","mname","cM","seq")

# add extra needed columns
Cclu_all$species <- rep(x = ">Cclu", times = length(Cclu_all[,1]))
Cclu_all$cM.null <- rep(x = 0, times = length(Cclu_all[,1]))
head(Cclu_all)

# reorder the columns:
Cclu_all <- Cclu_all[,c(5,1,3,6,2,4)]
head(Cclu_all)

# write out:
write.table(Cclu_all, file = "Cclu_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",") 

# end Cclu

###### Eluc (Rondeau et al 2014) ####
Eluc_all <- read.table(file = "rondeau_etal2014_map_and_seq.csv", sep = ",",
                          header = T)[,c(1,2,3,19)]
names(Eluc_all)
head(Eluc_all, n = 1)
colnames(Eluc_all) = c("mname","LG","cM","seq")
dim(Eluc_all) #571 records
head(Eluc_all, n =1)

# remove LG extra bits
Eluc_all$LG <- gsub(pattern = "LG-", replace = "", Eluc_all$LG)
# remove underscore and brackets from mname (ensure still all unique)
Eluc_all$mname <- gsub(pattern = "_.*", replace = "", Eluc_all$mname, perl = T)

# remove markers with MALE-1 MAP as cM position
Eluc_all <- Eluc_all[-which(Eluc_all$cM == "MALE-1 MAP"),]
dim(Eluc_all) # now will be 524 markers

# add extra bits
Eluc_all$species <- rep(x = ">Eluc", times = length(Eluc_all[,1]))
Eluc_all$cM.null <- rep(x = 0, times = length(Eluc_all[,1]))

# and re-order cols
head(Eluc_all, n =1)
Eluc_all <- Eluc_all[,c(5,2,3,6,1,4)]

# write out:
write.table(Eluc_all, file = "Eluc_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",", quote = F)

# Now all files are prepared for the find total position script of MapComp