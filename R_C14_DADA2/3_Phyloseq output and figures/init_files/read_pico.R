#Read C14 sorted pico PHYLOSEQ
# Load the phyloseq files
ps_pico <- read_rds(here("DADA2", "output_18SV4","TAN1810_18SV4phyloseq_sorted_pico.RDS"))

#copy the column of interest to create new column, and replacing names for water masses SA and ST
sample_data(ps_pico)$water_mass <- sample_data(ps_pico)$Cycle.
sample_data(ps_pico)$water_mass = str_replace(sample_data(ps_pico)$water_mass, "1|2|5", "SA") 
sample_data(ps_pico)$water_mass = str_replace(sample_data(ps_pico)$water_mass, "3|4", "ST")

#copy the column of interest, creating new column and replace for cycle names. Not using this column for now. 
sample_data(ps_pico)$cycle_location <- sample_data(ps_pico)$Cycle.
sample_data(ps_pico)$cycle_location = str_replace(sample_data(ps_pico)$cycle_location, "1", "C")
sample_data(ps_pico)$cycle_location = str_replace(sample_data(ps_pico)$cycle_location, "2", "D") 
sample_data(ps_pico)$cycle_location = str_replace(sample_data(ps_pico)$cycle_location, "5", "E") 
sample_data(ps_pico)$cycle_location = str_replace(sample_data(ps_pico)$cycle_location, "3", "A")
sample_data(ps_pico)$cycle_location = str_replace(sample_data(ps_pico)$cycle_location, "4", "B")

sample_data(ps_pico)$cycle_name <- sample_data(ps_pico)$Cycle.
sample_data(ps_pico)$cycle_name = str_replace(sample_data(ps_pico)$cycle_name, "1", "SA-Cycle_1")
sample_data(ps_pico)$cycle_name = str_replace(sample_data(ps_pico)$cycle_name, "2", "SA-Cycle_2") 
sample_data(ps_pico)$cycle_name = str_replace(sample_data(ps_pico)$cycle_name, "5", "SA-Cycle_5") 
sample_data(ps_pico)$cycle_name = str_replace(sample_data(ps_pico)$cycle_name, "3", "ST-Cycle_3")
sample_data(ps_pico)$cycle_name = str_replace(sample_data(ps_pico)$cycle_name, "4", "ST-Cycle_4")

sample_data(ps_pico)$cycle_location_name <- str_c(sample_data(ps_pico)$cycle_location, sample_data(ps_pico)$cycle_name, sep ="_")

sample_data(ps_pico)$cycle_exp_location_name <- str_c(sample_data(ps_pico)$cycle_location, sample_data(ps_pico)$cycle_name, sample_data(ps_pico)$EXP., sep ="_")

sample_data(ps_pico)$cycle_name_2 <- sample_data(ps_pico)$cycle_name
sample_data(ps_pico)$cycle_name_2 = str_replace(sample_data(ps_pico)$cycle_name_2, "SA-Cycle_1", "SA1")
sample_data(ps_pico)$cycle_name_2 = str_replace(sample_data(ps_pico)$cycle_name_2, "SA-Cycle_2", "SA2") 
sample_data(ps_pico)$cycle_name_2 = str_replace(sample_data(ps_pico)$cycle_name_2, "SA-Cycle_5", "SA3")
sample_data(ps_pico)$cycle_name_2 = str_replace(sample_data(ps_pico)$cycle_name_2, "ST-Cycle_3", "ST1") 
sample_data(ps_pico)$cycle_name_2 = str_replace(sample_data(ps_pico)$cycle_name_2, "ST-Cycle_4", "ST2")

sample_data(ps_pico)$cycle_exp <- str_c(sample_data(ps_pico)$cycle_name_2, sample_data(ps_pico)$EXP., sep ="_")

#vial type
sample_data(ps_pico)$vial_type <- sample_data(ps_pico)$vial
sample_data(ps_pico)$vial_type = str_replace(sample_data(ps_pico)$vial_type, "i", "initial") 
sample_data(ps_pico)$vial_type = str_replace(sample_data(ps_pico)$vial_type, "A|B|C", "light")
sample_data(ps_pico)$vial_type = str_replace(sample_data(ps_pico)$vial_type, "D", "dark")

# Remove ASVs that are not present in the dataset
ps_pico <- ps_pico %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 

junk <- data.frame(ps_pico@sam_data)
## Filtration based on taxonomy - remove metazoa and fungi
ps_pico <- ps_pico %>%
    subset_taxa(!(division %in% c("Metazoa", "Fungi"))) %>%
    subset_taxa(!(class == "Embryophyceae"))  %>% # to remove the plants.Likely from contamination. Checked with Adriana and Daniel, ok to remove.
    subset_taxa(!(species == "Padina_australis")) %>%
    subset_taxa(!(supergroup %in% c("Opisthokonta")))%>%
    subset_taxa(!(division %in% c("Pseudofungi"))) %>%
    subset_taxa(!(class %in% c("Syndiniales")))
