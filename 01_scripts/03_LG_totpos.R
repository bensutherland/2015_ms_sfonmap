# Developed by Eric Normandeau and Ben Sutherland from the Bernatchez lab at U. Laval, Quebec
# Calculates the total cM position across all linkage groups from a genetic map
# in the following format:
# e.g. Cclu marker: 
# >Cclu,1,0,0,63776,GTATGA

rm(list=ls())

data <- read.csv(file = 
                   "02_raw_data/all_species.csv",
                 header = F, col.names = c("sp","lg","pos","totpos","mname","seq"))
head(data)
levels(data$sp)
str(data) # make sure lg is integer
str(data$lg) # needed to make these all parallel so I can make a for loop to generate absolute position for each species
data$lg <- as.numeric(data$lg)


## 

lg.unique = NULL
data.new = NULL
spec.sp.data = NULL
data$totpos = 0

for (species in levels(data$sp)) {
    print(species)
    spec.sp.data <- data[data$sp == species, ]
    #print(paste("test",species))
    lg.unique = unique(spec.sp.data$lg)
    count = 0
    
    for (i in 1:(length(lg.unique) - 1)) {
      print(i)
      maximum = max(spec.sp.data$pos[as.integer(spec.sp.data$lg) == i])
      print(maximum)
      for (j in (i+1):length(lg.unique)) {
         spec.sp.data$totpos[as.integer(spec.sp.data$lg) == j] = 
            spec.sp.data$totpos[as.integer(spec.sp.data$lg) == j] + maximum
      }
    }
    data.new <- rbind(data.new, spec.sp.data)    
}

data.new$totpos = data.new$totpos + data.new$pos

head(data.new, n = 1000)[,1:4] # just to check

# save out the file with its total position calculated
write.table(x = data.new, file = "02_raw_data/all_species_w_totpos.csv", row.names =F, quote = F, sep = ",", col.names = F)

