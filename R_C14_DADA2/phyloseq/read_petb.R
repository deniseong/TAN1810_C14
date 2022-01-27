# CTD-petB Denise primer

# Load the phyloseq files
ps_ctd_nested <- read_rds("output_petb_2x300/output_petb_Denise/merged_v2/petB_Denise primer_phyloseq_CTD.RDS") 

#copy the column of interest to create new column, and replacing names for water masses SA and ST
sample_data(ps_ctd_nested)$water_mass <- sample_data(ps_ctd_nested)$cycle
sample_data(ps_ctd_nested)$water_mass = str_replace(sample_data(ps_ctd_nested)$water_mass, "1|2|5", "SA") 
sample_data(ps_ctd_nested)$water_mass = str_replace(sample_data(ps_ctd_nested)$water_mass, "3|4", "ST")

#copy the column of interest, creating new column and replace for cycle names. Not using this column for now. 
sample_data(ps_ctd_nested)$cycle_location <- sample_data(ps_ctd_nested)$cycle
sample_data(ps_ctd_nested)$cycle_location = str_replace(sample_data(ps_ctd_nested)$cycle_location, "1", "C")
sample_data(ps_ctd_nested)$cycle_location = str_replace(sample_data(ps_ctd_nested)$cycle_location, "2", "D") 
sample_data(ps_ctd_nested)$cycle_location = str_replace(sample_data(ps_ctd_nested)$cycle_location, "5", "E") 
sample_data(ps_ctd_nested)$cycle_location = str_replace(sample_data(ps_ctd_nested)$cycle_location, "3", "A")
sample_data(ps_ctd_nested)$cycle_location = str_replace(sample_data(ps_ctd_nested)$cycle_location, "4", "B")

sample_data(ps_ctd_nested)$cycle_name <- sample_data(ps_ctd_nested)$cycle
sample_data(ps_ctd_nested)$cycle_name = str_replace(sample_data(ps_ctd_nested)$cycle_name, "1", "SA-Cycle_1")
sample_data(ps_ctd_nested)$cycle_name = str_replace(sample_data(ps_ctd_nested)$cycle_name, "2", "SA-Cycle_2") 
sample_data(ps_ctd_nested)$cycle_name = str_replace(sample_data(ps_ctd_nested)$cycle_name, "5", "SA-Cycle_5") 
sample_data(ps_ctd_nested)$cycle_name = str_replace(sample_data(ps_ctd_nested)$cycle_name, "3", "ST-Cycle_3")
sample_data(ps_ctd_nested)$cycle_name = str_replace(sample_data(ps_ctd_nested)$cycle_name, "4", "ST-Cycle_4")

sample_data(ps_ctd_nested)$cycle_location_name <- str_c(sample_data(ps_ctd_nested)$cycle_location, sample_data(ps_ctd_nested)$cycle_name, sep ="_")
sample_data(ps_ctd_nested)$cycle_station_location_name <- str_c(sample_data(ps_ctd_nested)$cycle_location, sample_data(ps_ctd_nested)$cycle_name, sample_data(ps_ctd_nested)$station, sep ="_")

# Remove ASVs that are not present in the dataset
ps_ctd_nested <- ps_ctd_nested %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 

#Remove Richellia
ps_ctd_nested <- ps_ctd_nested %>% 
    subset_taxa(!(Genus == "Rich")) 

# Do normalizations and transformation
ps_ctd_nested <- phyloseq_normalize_median(ps_ctd_nested)
long_ctd_nested <- phyloseq_transform_to_long(ps_ctd_nested)


# CTD - petB Mazard primer
##Read data

# Load the phyloseq files
ps_ctd_normal <- read_rds("output_petb_2x300/output_petb_Mazard/merged_v2/petB Mazard primer_phyloseq_CTD.RDS")  # adding new component, this case the phyloseq object to the "tag" all

#copy the column of interest to create new column, and replacing names for water masses SA and ST
sample_data(ps_ctd_normal)$water_mass <- sample_data(ps_ctd_normal)$cycle
sample_data(ps_ctd_normal)$water_mass = str_replace(sample_data(ps_ctd_normal)$water_mass, "1|2|5", "SA") 
sample_data(ps_ctd_normal)$water_mass = str_replace(sample_data(ps_ctd_normal)$water_mass, "3|4", "ST")

#copy the column of interest, creating new column and replace for cycle names. Not using this column for now. 
sample_data(ps_ctd_normal)$cycle_location <- sample_data(ps_ctd_normal)$cycle
sample_data(ps_ctd_normal)$cycle_location = str_replace(sample_data(ps_ctd_normal)$cycle_location, "1", "C")
sample_data(ps_ctd_normal)$cycle_location = str_replace(sample_data(ps_ctd_normal)$cycle_location, "2", "D") 
sample_data(ps_ctd_normal)$cycle_location = str_replace(sample_data(ps_ctd_normal)$cycle_location, "5", "E") 
sample_data(ps_ctd_normal)$cycle_location = str_replace(sample_data(ps_ctd_normal)$cycle_location, "3", "A")
sample_data(ps_ctd_normal)$cycle_location = str_replace(sample_data(ps_ctd_normal)$cycle_location, "4", "B")

sample_data(ps_ctd_normal)$cycle_name <- sample_data(ps_ctd_normal)$cycle
sample_data(ps_ctd_normal)$cycle_name = str_replace(sample_data(ps_ctd_normal)$cycle_name, "1", "SA-Cycle_1")
sample_data(ps_ctd_normal)$cycle_name = str_replace(sample_data(ps_ctd_normal)$cycle_name, "2", "SA-Cycle_2") 
sample_data(ps_ctd_normal)$cycle_name = str_replace(sample_data(ps_ctd_normal)$cycle_name, "5", "SA-Cycle_5") 
sample_data(ps_ctd_normal)$cycle_name = str_replace(sample_data(ps_ctd_normal)$cycle_name, "3", "ST-Cycle_3")
sample_data(ps_ctd_normal)$cycle_name = str_replace(sample_data(ps_ctd_normal)$cycle_name, "4", "ST-Cycle_4")

sample_data(ps_ctd_normal)$cycle_location_name <- str_c(sample_data(ps_ctd_normal)$cycle_location, sample_data(ps_ctd_normal)$cycle_name, sep ="_")
sample_data(ps_ctd_normal)$cycle_station_location_name <- str_c(sample_data(ps_ctd_normal)$cycle_location, sample_data(ps_ctd_normal)$cycle_name, sample_data(ps_ctd_normal)$station, sep ="_")

# Remove ASVs that are not present in the dataset
ps_ctd_normal <- ps_ctd_normal %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 

# Remove Richellia
ps_ctd_normal <- ps_ctd_normal %>% 
      subset_taxa(!(Genus == "Rich")) 

# Do normalizations and transformation
ps_ctd_normal <- phyloseq_normalize_median(ps_ctd_normal)
long_ctd_normal <- phyloseq_transform_to_long(ps_ctd_normal)

# Sorted syn initials
# Load the phyloseq files
ps_sorted <- read_rds("output_petb_2x300/output_petb_Denise/merged_v2/petB_Denise primer_phyloseq_sortedsyn.RDS") 

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

# Do normalizations and transformation
ps_sorted <- phyloseq_normalize_median(ps_sorted)
long_sorted <- phyloseq_transform_to_long(ps_sorted)

junk <- data.frame(ps_sorted@sam_data)
