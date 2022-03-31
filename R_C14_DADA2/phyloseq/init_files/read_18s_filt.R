# Load the phyloseq files - from Denise processing
ps_18s_filt<- read_rds(here("output_18SV4", "TAN1810_18SV4phyloseq_CTD_18SV4.RDS"))

# from sediment trap phyloseq- subset only CTD samples
ps_18s_filt_1<- read_rds(here("metapr2_phyloseq_asv_set_47_Eukaryota.rds"))

# create a new column as sample. To categorise the samples as "trap_blank", "water_CTD", "trap_live", "trap_fix", water_pump, core
# combine column substrate, substrate_description and sample_fixation. need to replace NA as "NA" in sample_fixation and substrate description.
sample_data(ps_18s_filt_1)$sample_fixation <- str_replace_na(sample_data(ps_18s_filt_1)$sample_fixation)
sample_data(ps_18s_filt_1)$substrate_description <- str_replace_na(sample_data(ps_18s_filt_1)$substrate_description)


sample_data(ps_18s_filt_1)$sample <- str_c(sample_data(ps_18s_filt_1)$substrate, sample_data(ps_18s_filt_1)$substrate_description, sample_data(ps_18s_filt_1)$sample_fixation, sep ="_")

sample_data(ps_18s_filt_1)$sample <- str_replace(sample_data(ps_18s_filt_1)$sample, "sediment trap blank_Sediment trap samples_NA", "trap_blank_live")
sample_data(ps_18s_filt_1)$sample <- str_replace(sample_data(ps_18s_filt_1)$sample, "sediment trap blank_Sediment trap samples_fixed", "trap_blank_fix")
sample_data(ps_18s_filt_1)$sample <- str_replace(sample_data(ps_18s_filt_1)$sample, "water_NA_NA", "water_CTD")
sample_data(ps_18s_filt_1)$sample <- str_replace(sample_data(ps_18s_filt_1)$sample, "sediment trap material_Sediment trap samples_fixed", "trap_fix")
sample_data(ps_18s_filt_1)$sample <- str_replace(sample_data(ps_18s_filt_1)$sample, "sediment trap material_Sediment trap samples_NA", "trap_live")
sample_data(ps_18s_filt_1)$sample <- str_replace(sample_data(ps_18s_filt_1)$sample, "water_McLane pump_NA", "water_pump")
sample_data(ps_18s_filt_1)$sample <- str_replace(sample_data(ps_18s_filt_1)$sample, "sediment_Sediment core_NA", "core")

junk <- data.frame(ps_filt_merge@sam_data)
junk2<- data.frame(ps_filt_merge@tax_table)

ps_18s_filt_2 <-  subset_samples(ps_18s_filt_1, sample == "water_CTD")
sample_data(ps_18s_filt_2)$cycle <- sample_data(ps_18s_filt_2)$station_set
sample_data(ps_18s_filt_2)$ctd_cast <- sample_data(ps_18s_filt_2)$metadata_remark
sample_data(ps_18s_filt_2)$station <- sample_data(ps_18s_filt_2)$station_id
sample_data(ps_18s_filt)$metadata_code <- sample_data(ps_18s_filt)$sample_name_old
sample_data(ps_18s_filt)$cycle = str_replace(sample_data(ps_18s_filt)$cycle, "1", "Cycle_1")

ps_filt_merge <- merge_phyloseq(ps_18s_filt,ps_18s_filt_2)

#copy the column of interest to create new column, and replacing names for water masses SA and ST
sample_data(ps_filt_merge)$water_mass <- sample_data(ps_filt_merge)$cycle
sample_data(ps_filt_merge)$water_mass = str_replace(sample_data(ps_filt_merge)$water_mass, "Cycle_1|Cycle_1A|Cycle_1B|Cycle_2|Cycle_5", "SA") 
sample_data(ps_filt_merge)$water_mass = str_replace(sample_data(ps_filt_merge)$water_mass, "Cycle_3|Cycle_4", "ST")

#copy the column of interest, creating new column and replace for cycle names. Not using this column for now. 
#sample_data(ps_18s_filt)$cycle_location <- sample_data(ps_18s_filt)$cycle
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "1", "C")
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "2", "D") 
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "5", "E") 
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "3", "A")
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "4", "B")

#sample_data(ps_18s_filt)$cycle_name <- sample_data(ps_18s_filt)$cycle
#sample_data(ps_18s_filt)$cycle_name = str_replace(sample_data(ps_18s_filt)$cycle_name, "1", "SA-Cycle_1")
#sample_data(ps_18s_filt)$cycle_name = str_replace(sample_data(ps_18s_filt)$cycle_name, "2", "SA-Cycle_2") 
#sample_data(ps_18s_filt)$cycle_name = str_replace(sample_data(ps_18s_filt)$cycle_name, "5", "SA-Cycle_5") 
#sample_data(ps_18s_filt)$cycle_name = str_replace(sample_data(ps_18s_filt)$cycle_name, "3", "ST-Cycle_3")
#sample_data(ps_18s_filt)$cycle_name = str_replace(sample_data(ps_18s_filt)$cycle_name, "4", "ST-Cycle_4")

sample_data(ps_filt_merge)$cycle_station <- str_c(sample_data(ps_filt_merge)$cycle, sample_data(ps_filt_merge)$station, sep ="_")

# Remove ASVs that are not present in the dataset
ps_filt_merge <- ps_filt_merge %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 
## Filtration based on taxonomy - remove metazoa and fungi
ps_filt_merge<- ps_filt_merge %>% 
    subset_taxa(!(division %in% c("Metazoa", "Fungi"))) %>%
    subset_taxa(!(class == "Embryophyceae")) # to remove the plants.Likely from contamination. Checked with Adriana and Daniel, ok to remove.
