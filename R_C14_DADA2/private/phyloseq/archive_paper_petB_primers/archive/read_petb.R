# Filtered samples -petB Ong_2022 primer

# Load the phyloseq files
ps_filt_ong <- read_rds(here("4.2_Ong_2022", "petB_Denise primer_phyloseq_CTD.RDS"))

#copy the column of interest to create new column, and replacing names for water masses SA and ST
sample_data(ps_filt_ong)$water_mass <- sample_data(ps_filt_ong)$cycle
sample_data(ps_filt_ong)$water_mass = str_replace(sample_data(ps_filt_ong)$water_mass, "1|2|5", "SA") 
sample_data(ps_filt_ong)$water_mass = str_replace(sample_data(ps_filt_ong)$water_mass, "3|4", "ST")

#copy the column of interest, creating new column and replace for cycle names. Not using this column for now. 
sample_data(ps_filt_ong)$cycle_location <- sample_data(ps_filt_ong)$cycle
sample_data(ps_filt_ong)$cycle_location = str_replace(sample_data(ps_filt_ong)$cycle_location, "1", "C")
sample_data(ps_filt_ong)$cycle_location = str_replace(sample_data(ps_filt_ong)$cycle_location, "2", "D") 
sample_data(ps_filt_ong)$cycle_location = str_replace(sample_data(ps_filt_ong)$cycle_location, "5", "E") 
sample_data(ps_filt_ong)$cycle_location = str_replace(sample_data(ps_filt_ong)$cycle_location, "3", "A")
sample_data(ps_filt_ong)$cycle_location = str_replace(sample_data(ps_filt_ong)$cycle_location, "4", "B")

sample_data(ps_filt_ong)$cycle_name <- sample_data(ps_filt_ong)$cycle
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "1", "SA-Cycle_1")
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "2", "SA-Cycle_2") 
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "5", "SA-Cycle_5") 
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "3", "ST-Cycle_3")
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "4", "ST-Cycle_4")

sample_data(ps_filt_ong)$cycle_location_name <- str_c(sample_data(ps_filt_ong)$cycle_location, sample_data(ps_filt_ong)$cycle_name, sep ="_")
sample_data(ps_filt_ong)$cycle_station_location_name <- str_c(sample_data(ps_filt_ong)$cycle_location, sample_data(ps_filt_ong)$cycle_name, sample_data(ps_filt_ong)$station, sep ="_")

# Remove ASVs that are not present in the dataset
ps_filt_ong <- ps_filt_ong %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 

#Remove Richelia
ps_filt_ong <- ps_filt_ong %>% 
    subset_taxa(!(Genus == "Rich")) 

# Do normalizations and transformation
ps_filt_ong <- phyloseq_normalize_median(ps_filt_ong)
long_filt_ong <- phyloseq_transform_to_long(ps_filt_ong)


# Filtered samples - petB Mazard_2012 primer

# Load the phyloseq files
ps_filt_mazard <- read_rds(here("4.1_Mazard_2012", "petB Mazard primer_phyloseq_CTD.RDS"))

#copy the column of interest to create new column, and replacing names for water masses SA and ST
sample_data(ps_filt_mazard)$water_mass <- sample_data(ps_filt_mazard)$cycle
sample_data(ps_filt_mazard)$water_mass = str_replace(sample_data(ps_filt_mazard)$water_mass, "1|2|5", "SA") 
sample_data(ps_filt_mazard)$water_mass = str_replace(sample_data(ps_filt_mazard)$water_mass, "3|4", "ST")

#copy the column of interest, creating new column and replace for cycle names. Not using this column for now. 
sample_data(ps_filt_mazard)$cycle_location <- sample_data(ps_filt_mazard)$cycle
sample_data(ps_filt_mazard)$cycle_location = str_replace(sample_data(ps_filt_mazard)$cycle_location, "1", "C")
sample_data(ps_filt_mazard)$cycle_location = str_replace(sample_data(ps_filt_mazard)$cycle_location, "2", "D") 
sample_data(ps_filt_mazard)$cycle_location = str_replace(sample_data(ps_filt_mazard)$cycle_location, "5", "E") 
sample_data(ps_filt_mazard)$cycle_location = str_replace(sample_data(ps_filt_mazard)$cycle_location, "3", "A")
sample_data(ps_filt_mazard)$cycle_location = str_replace(sample_data(ps_filt_mazard)$cycle_location, "4", "B")

sample_data(ps_filt_mazard)$cycle_name <- sample_data(ps_filt_mazard)$cycle
sample_data(ps_filt_mazard)$cycle_name = str_replace(sample_data(ps_filt_mazard)$cycle_name, "1", "SA-Cycle_1")
sample_data(ps_filt_mazard)$cycle_name = str_replace(sample_data(ps_filt_mazard)$cycle_name, "2", "SA-Cycle_2") 
sample_data(ps_filt_mazard)$cycle_name = str_replace(sample_data(ps_filt_mazard)$cycle_name, "5", "SA-Cycle_5") 
sample_data(ps_filt_mazard)$cycle_name = str_replace(sample_data(ps_filt_mazard)$cycle_name, "3", "ST-Cycle_3")
sample_data(ps_filt_mazard)$cycle_name = str_replace(sample_data(ps_filt_mazard)$cycle_name, "4", "ST-Cycle_4")

sample_data(ps_filt_mazard)$cycle_location_name <- str_c(sample_data(ps_filt_mazard)$cycle_location, sample_data(ps_filt_mazard)$cycle_name, sep ="_")
sample_data(ps_filt_mazard)$cycle_station_location_name <- str_c(sample_data(ps_filt_mazard)$cycle_location, sample_data(ps_filt_mazard)$cycle_name, sample_data(ps_filt_mazard)$station, sep ="_")

# Remove ASVs that are not present in the dataset
ps_filt_mazard <- ps_filt_mazard %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 

# Remove Richellia
ps_filt_mazard <- ps_filt_mazard %>% 
      subset_taxa(!(Genus == "Rich")) 

# Do normalizations and transformation
ps_filt_mazard <- phyloseq_normalize_median(ps_filt_mazard)
long_filt_mazard <- phyloseq_transform_to_long(ps_filt_mazard)

# Sorted syn initials
# Load the phyloseq files
ps_sorted <- read_rds(here("4.2_Ong_2022", "petB_Denise primer_phyloseq_sortedsyn_initials.RDS"))

#copy the column of interest to create new column, and replacing names for water masses SA and ST
sample_data(ps_sorted)$water_mass <- sample_data(ps_sorted)$Cycle.
sample_data(ps_sorted)$water_mass = str_replace(sample_data(ps_sorted)$water_mass, "1|2|5", "SA") 
sample_data(ps_sorted)$water_mass = str_replace(sample_data(ps_sorted)$water_mass, "3|4", "ST")

#copy the column of interest, creating new column and replace for cycle names. Not using this column for now. 
sample_data(ps_sorted)$cycle_location <- sample_data(ps_sorted)$Cycle.
sample_data(ps_sorted)$cycle_location = str_replace(sample_data(ps_sorted)$cycle_location, "1", "C")
sample_data(ps_sorted)$cycle_location = str_replace(sample_data(ps_sorted)$cycle_location, "2", "D") 
sample_data(ps_sorted)$cycle_location = str_replace(sample_data(ps_sorted)$cycle_location, "5", "E") 
sample_data(ps_sorted)$cycle_location = str_replace(sample_data(ps_sorted)$cycle_location, "3", "A")
sample_data(ps_sorted)$cycle_location = str_replace(sample_data(ps_sorted)$cycle_location, "4", "B")

sample_data(ps_sorted)$cycle_name <- sample_data(ps_sorted)$Cycle.
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "1", "SA-Cycle_1")
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "2", "SA-Cycle_2") 
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "5", "SA-Cycle_5") 
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "3", "ST-Cycle_3")
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "4", "ST-Cycle_4")
sample_data(ps_sorted)$cycle_location_name <- str_c(sample_data(ps_sorted)$cycle_location, sample_data(ps_sorted)$cycle_name, sep ="_")
sample_data(ps_sorted)$cycle_exp_location_name <- str_c(sample_data(ps_sorted)$cycle_location, sample_data(ps_sorted)$cycle_name, sample_data(ps_sorted)$EXP., sep ="_")

#vial type
sample_data(ps_sorted)$vial_type <- sample_data(ps_sorted)$vial
sample_data(ps_sorted)$vial_type = str_replace(sample_data(ps_sorted)$vial_type, "i", "initial") 
sample_data(ps_sorted)$vial_type = str_replace(sample_data(ps_sorted)$vial_type, "A|B|C", "light")
sample_data(ps_sorted)$vial_type = str_replace(sample_data(ps_sorted)$vial_type, "D", "dark")

# Remove ASVs that are not present in the dataset
ps_sorted <- ps_sorted %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 

# Remove Richellia
ps_sorted <- ps_sorted %>% 
  subset_taxa(!(Genus == "Rich")) 

# Do normalizations and transformation
ps_sorted <- phyloseq_normalize_median(ps_sorted)
long_sorted <- phyloseq_transform_to_long(ps_sorted)

junk <- data.frame(ps_sorted@sam_data)
