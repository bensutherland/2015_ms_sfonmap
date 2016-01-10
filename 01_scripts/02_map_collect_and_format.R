# Developed by Ben Sutherland from the Bernatchez lab at U. Laval, Quebec
# After collecting all of the supplemental files, format all datafiles to be used by MapComp
# Due to custom nature and difference in supplied data, this script works per species

# rm(list=ls())

library(tidyr)

# Set working directory to the main directory of the repo

# For each species, we want the following information (in order):
# >Species  LG  LGcM  totposcM  mname sequence


#
###### Otsh (Brieuc et al 2014) #####
# import seq file
Otsh_nondup_loci <- read.csv(file = "brieuc_etal2014-non-dup_lociS1.1.csv")
# import map file
Otsh_map <- read.csv(file = "brieuc_etal2014-consensus_haploid_mapS2.1.csv")[,1:3]

# merge seq and map files
Otsh_merged <- merge(Otsh_map, Otsh_nondup_loci, by = "Marker")

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

###### Chum (Waples et al 2015) #####

# import seq file
Oket_loci <- read.table(file = "waples_etal2015_map2-revised.txt",
                        header = T, sep = "\t")[,c(2:5)]
colnames(Oket_loci) <- c("Marker", "LG", "cM", "Sequence")
dim(Oket_loci) #6119 records
head(Oket_loci)

# minor cleaning to remove '_x1' from Marker
Oket_loci$Marker <- gsub(pattern = "_x1", replacement = "", x = Oket_loci$Marker)
head(Oket_loci)

# merge seq and map files
Oket_merged_sorted <- Oket_loci[with(Oket_loci, order(Oket_loci$LG, Oket_loci$cM)), ]
head(Oket_merged_sorted)

# add extra needed columns
Oket_merged_sorted_clean <- Oket_merged_sorted
Oket_merged_sorted_clean$species <- rep(">Oket", times = length(Oket_merged_sorted$Marker))
Oket_merged_sorted_clean$cM.null <- rep(0, times = length(Oket_merged_sorted$Marker))

# reorder the columns:
Oket_merged_sorted_clean <- Oket_merged_sorted_clean[,c(5,2,3,6,1,4)]
head(Oket_merged_sorted_clean)

# write out:
write.table(Oket_merged_sorted_clean, file = "Oket_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

# end Oket

###### Coho (Kodama et al 2014) ####
# import seq file
Okis_loci <- read.csv(file = "kodama_etal2014-coho_non-dup_RAD_lociS1.1.csv")[,1:2]
dim(Okis_loci) #52936 records

# import map file
Okis_map <- read.csv(file = "kodama_etal2014-coho_map_fem_haploidS2.1.csv")
colnames(Okis_map) <- c("Marker","LG","cM")
dim(Okis_map) #6643 entries

# merge seq and map files
Okis_merged <- merge(Okis_map, Okis_loci, by = "Marker")
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

###### Cclu (Gagnaire et al 2013) ####
# note: map and seq already in same file
# import map and seq file
Cclu_merged_sorted <- read.csv(file = "gagnaire_etal2013-RAD_loci_and_map.csv")
head(Cclu_merged_sorted)
dim(Cclu_merged_sorted)  #3438 markers

# sort by chromosome then by map distance
# NA

# minor cleaning
#NA
Cclu_merged_sorted_clean <- Cclu_merged_sorted

# add extra needed columns
Cclu_merged_sorted_clean$species <- rep(x = ">Cclu", times = length(Cclu_merged_sorted_clean[,1]))
Cclu_merged_sorted_clean$cM.null <- rep(x = 0, times = length(Cclu_merged_sorted_clean[,1]))

# reorder the columns:
Cclu_merged_sorted_clean <- Cclu_merged_sorted_clean[,c(5,3,4,6,1,2)]
head(Cclu_merged_sorted_clean)

# write out:
write.table(Cclu_merged_sorted_clean, file = "Cclu_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",") 

# end Cclu

###### Sfon (current study) #######
#import seq file
Sfon_seq <- read.table(file = "sutherland_etal-GBS_loci_complete.txt", sep = "\t",
                       header = T, col.names = c("Marker", "Sequence"))
dim(Sfon_seq) # 6448 markers

#import map file
Sfon_map <- read.table(file = "sutherland_etal_LG_P2.tsv",
                       sep = "\t", header = T)[,c(1,4,2)]
colnames(Sfon_map) = c("Marker","cM", "LG")
dim(Sfon_map) #3826 markers
head(Sfon_map)

# minor cleaning
Sfon_map$LG <- as.numeric(gsub(pattern = "LG", replacement="", x = Sfon_map$LG))
head(Sfon_map)

# merge seq and map file
Sfon_merged <- merge(Sfon_map, Sfon_seq, by = "Marker")
dim(Sfon_merged) #3715 markers

# sort by chromosome then by map distance
Sfon_merged_sorted <- Sfon_merged[with(Sfon_merged, order(Sfon_merged$LG, Sfon_merged$cM)), ]
Sfon_merged_sorted_clean <- Sfon_merged_sorted

# add extra needed columns
Sfon_merged_sorted_clean$species <- rep(x = ">Sfon", times = length(Sfon_merged_sorted_clean[,1]))
Sfon_merged_sorted_clean$cM.null <- rep(x = 0, times = length(Sfon_merged_sorted_clean[,1]))
head(Sfon_merged_sorted_clean)

# reorder the columns:
Sfon_merged_sorted_clean <- Sfon_merged_sorted_clean[,c(5,3,2,6,1,4)]

# write out:
write.table(Sfon_merged_sorted_clean, file = "Sfon_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

# end Sfon


###### Sfon (Sauvage et al 2012) ####
#import seq file
SfonEST_seq <- read.table(file = "sauvage_etal2012-TableS4.csv", 
                       sep = ",", header = T)[-c(1,2),c(2,3)]

dim(SfonEST_seq) # 280 markers
colnames(SfonEST_seq) <- c("mname","seq")

#import map file
# first do a little cleanup of the file to put it into a better order (isolate the data needed, then transpose and add column headers)
SfonEST_map <- read.table(file = "sauvage_etal2012-FileS2_Genotyping_data_cleaned_up.csv", sep = ",", header = T)
str(SfonEST_map)
dim(SfonEST_map)

# SfonEST_map <- read.table(file = "sauvage_etal2012-FileS2_Genotyping_data.csv",
#                        sep = ",", header = F)[1:3, -1]
# dim(SfonEST_map) #266 markers
# head(SfonEST_map)

# SfonEST_map <- as.data.frame(t(SfonEST_map))

# colnames(SfonEST_map) <- c("mname","LG","cM")
# head(SfonEST_map)
# str(SfonEST_map)

# change LG and cM as numeric:
# SfonEST_map[,2] <- as.numeric(levels(SfonEST_map[,2]))
# SfonEST_map[,2]
# SfonEST_map[,3] <- as.numeric(levels(SfonEST_map[,3]))
# SfonEST_map[,3]
# head(SfonEST_map)
# str(SfonEST_map)

# merge
SfonEST_merged <- merge(SfonEST_map, SfonEST_seq, by = "mname")
dim(SfonEST_merged) #only 186 markers have sequence provided out of the total of 266 markers on the map


 
SfonEST_merged_sorted <- SfonEST_merged[with(SfonEST_merged, order(SfonEST_merged$LG, 
                                                                SfonEST_merged$cM)), ]

SfonEST_merged_sorted_clean <- SfonEST_merged_sorted
SfonEST_merged_sorted_clean$species <- rep(x = ">SfonEST", times = length(SfonEST_merged_sorted_clean[,1]))
SfonEST_merged_sorted_clean$cM.null <- rep(x = 0, times = length(SfonEST_merged_sorted_clean[,1]))
head(SfonEST_merged_sorted_clean)
SfonEST_merged_sorted_clean <- SfonEST_merged_sorted_clean[,c(5,2,3,6,1,4)]

write.table(SfonEST_merged_sorted_clean, file = "SfonEST_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

###### Oner3 (Larson et al 2016) ####
# note, first remove any cases with 'NA' (these are non-positioned markers)
## grep -v 'NA' larson_etal2015_table_s1_male_and_female_map_info.csv > larson_etal2015_table_s1_male_and_female_map_info_noNA.csv
# import seq file
Oner3_seq <- read.csv(file = "larson_etal2015_table_s1_male_and_female_map_info_noNA.csv", header = T)
colnames(Oner3_seq) <- c("Marker","LG","cM","seq")                     
head(Oner3_seq)
tail(Oner3_seq)
dim(Oner3_seq) #6262 markers
str(Oner3_seq)

# note there is a So09 and So09.5

Oner3_seq$species <- rep(x = ">Oner3", times = length(Oner3_seq[,1]))
Oner3_seq$cM.null <- rep(x = 0, times = length(Oner3_seq[,1]))
head(Oner3_seq)

# reorder the columns:
Oner3_seq <- Oner3_seq[,c(5,2,3,6,1,4)]
head(Oner3_seq)

#write out
write.table(Oner3_seq, file = "Oner3_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

###### Eluc (Rondeau et al 2014) ####
# import seq and map file
Eluc_merged_sorted <- read.table(file = "rondeau_etal2014-mname_LG_cM_and_seq.csv", sep = ",",
                          header = F, col.names = c("mname","LG","cM","seq"))
dim(Eluc_merged_sorted) #526 records
head(Eluc_merged_sorted)

# remove LG extra
Eluc_merged_sorted$LG <- gsub(pattern = "LG-", replace = "", Eluc_merged_sorted$LG)
# remove underscore and brackets from mname (ensure still all unique)
Eluc_merged_sorted$mname <- gsub(pattern = "_.*", replace = "", Eluc_merged_sorted$mname, perl = T)
# remove 'MALE-1' position markers
Eluc_merged_sorted <- Eluc_merged_sorted[-grep(pattern = "MALE-1", x = Eluc_merged_sorted$cM),]
dim(Eluc_merged_sorted)

# add extra bits
Eluc_merged_sorted$species <- rep(x = ">Eluc", times = length(Eluc_merged_sorted[,1]))
Eluc_merged_sorted$cM.null <- rep(x = 0, times = length(Eluc_merged_sorted[,1]))

# and re-order cols
Eluc_merged_sorted <- Eluc_merged_sorted[,c(5,2,3,6,1,4)]

# write out:
write.table(Eluc_merged_sorted, file = "Eluc_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

###### Ssal (Lien et al 2011) ####

# import seq and map file
Ssal_merged_sorted <- read.table(file = "lien_etal2011-addfile1-prepped_for_R.csv", sep = ",",
                                 header = F, col.names = c("mname","LG","cM","seq"))
dim(Ssal_merged_sorted) #5650 records
head(Ssal_merged_sorted)[,1:3]

# remove LG extra
Ssal_merged_sorted$LG <- gsub(pattern = "ssa", replace = "", Ssal_merged_sorted$LG)

# add extra bits
Ssal_merged_sorted$species <- rep(x = ">Ssal", times = length(Ssal_merged_sorted[,1]))
Ssal_merged_sorted$cM.null <- rep(x = 0, times = length(Ssal_merged_sorted[,1]))

# and re-order cols
Ssal_merged_sorted <- Ssal_merged_sorted[,c(5,2,3,6,1,4)]

# write out:
write.table(Ssal_merged_sorted, file = "Ssal_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")

###### Omyk (Palti et al 2015) ####
Omyk_cM <- read.csv(file = "palti_etal2015-mname_and_cM.csv", header = F)
dim(Omyk_cM) #1167 markers
colnames(Omyk_cM) = c("mname", "cM")
head(Omyk_cM)

Omyk_chrom <- read.csv(file = "palti_etal2015-02_LGs_2-point_longform.csv", header = F)[,c(2,1)]
dim(Omyk_chrom) #5851 markers
colnames(Omyk_chrom) = c("mname","LG")
head(Omyk_chrom)
Omyk_chrom$LG <- 
  as.numeric(gsub(pattern = "Chr", replacement="", x = Omyk_chrom$LG, perl = T))
head(Omyk_chrom)
str(Omyk_chrom)


Omyk_fasta <- read.csv(file = "palti_etal2015-03_RAD_SNP_seqs.csv", header = T)
dim(Omyk_fasta) #5612 markers
colnames(Omyk_fasta) = c("mname","seq")
head(Omyk_fasta) # need to remove [X/X] keep just the second X
# trim fasta file to remove one of the SNPs as [A/T] within the seq
# find and replace the following with nothing: \[[A-Z]/ and ]
Omyk_fasta$seq <- 
  gsub(pattern = "\\[[A-Z]/|\\]", replacement="", x = Omyk_fasta$seq, perl = T)
# and also fix marker name too
Omyk_fasta$mname <- gsub(pattern = "_.*", replace = "", Omyk_fasta$mname, perl = T)
head(Omyk_fasta) # now all is good.

# merge the files
temp <- merge(Omyk_chrom, Omyk_cM, by = "mname")
dim(temp) #1138 records
Omyk2_merged <- merge(temp, Omyk_fasta, by = "mname")
dim(Omyk2_merged) # only 955 markers
head(Omyk2_merged)
Omyk2_merged_sorted <- Omyk2_merged[with(Omyk2_merged, order(Omyk2_merged$LG, Omyk2_merged$cM)), ]
head(Omyk2_merged_sorted)
dim(Omyk2_merged_sorted) # only 955 markers for some reason...

# add extra bits
Omyk2_merged_sorted$species <- rep(x = ">Omyk2", times = length(Omyk2_merged_sorted[,1]))
Omyk2_merged_sorted$cM.null <- rep(x = 0, times = length(Omyk2_merged_sorted[,1]))

# and re-order cols
Omyk2_merged_sorted <- Omyk2_merged_sorted[,c(5,2,3,6,1,4)]

write.table(Omyk2_merged_sorted, file = "Omyk2_merged_sorted_clean.csv", row.names = F, col.names = F, sep = ",")
