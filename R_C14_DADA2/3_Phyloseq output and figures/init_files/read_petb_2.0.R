# Read all petB primer samples - Ong_2022 filtered and sorted samples, Mazard_2012 filtered samples
# Filtered samples -petB Ong_2022 primer

# Load the phyloseq files
ps_filt_ong <- read_rds(here("2.1_petB", "TAN1810_petB_nested_phyloseq_asv_set_nestedCTD.RDS"))

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
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "1", "SA1")
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "2", "SA2") 
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "5", "SA3") 
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "3", "ST1")
sample_data(ps_filt_ong)$cycle_name = str_replace(sample_data(ps_filt_ong)$cycle_name, "4", "ST2")

sample_data(ps_filt_ong)$cycle_location_name <- str_c(sample_data(ps_filt_ong)$cycle_location, sample_data(ps_filt_ong)$cycle_name, sep ="_")
sample_data(ps_filt_ong)$cycle_station_location_name <- str_c(sample_data(ps_filt_ong)$cycle_location, sample_data(ps_filt_ong)$cycle_name, sample_data(ps_filt_ong)$station, sep ="_")

# Remove ASVs that are not present in the dataset
ps_filt_ong <- ps_filt_ong %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 

#Remove Richelia
ps_filt_ong <- ps_filt_ong %>% 
    subset_taxa(!(Genus == "Rich")) 

# Remove sample 215
ps_filt_ong <- ps_filt_ong %>%
  subset_samples(sample_number!= "215")

# Do normalizations and transformation
ps_filt_ong <- phyloseq_normalize_median(ps_filt_ong)
long_filt_ong <- phyloseq_transform_to_long(ps_filt_ong)

# Sorted syn
# Load the phyloseq files
ps_sorted <- read_rds(here("2.1_petB", "TAN1810_petB_nested_phyloseq_asv_set_sortedsyn.RDS"))

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
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "5", "SA3")
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "1", "SA1")
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "2", "SA2") 

sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "3", "ST1")
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "4", "ST2")
sample_data(ps_sorted)$cycle_name = str_replace(sample_data(ps_sorted)$cycle_name, "SAST1", "SA3")
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

# Remove syn-01-20 and syn-02-5
ps_sorted <- ps_sorted %>%
  subset_samples(sample_name != "syn-01-20") %>%
  subset_samples(sample_name != "syn-02-5") %>%
  subset_samples(sample_name != "syn-negr1-2") 

# Remove Richellia
ps_sorted <- ps_sorted %>% 
  subset_taxa(!(Genus == "Rich")) 

# Do normalizations and transformation
ps_sorted <- phyloseq_normalize_median(ps_sorted)
long_sorted <- phyloseq_transform_to_long(ps_sorted)

junk <- data.frame(ps_sorted@sam_data)
