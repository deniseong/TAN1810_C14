#read merged phyloseq - asv set 47 processed by DV and dataset D4 processed by DO.
# contains all samples from TAN 1810 cruise from 2AM CTD filtered seawater samples, 18sv4 region.
ps_18s_filt<- read_rds(here("merge_filt_phyloseq","phyloseq_merge_asv_set_47_Eukaryota_D4_filt_seqhash.RDS"))

#copy the column of interest, creating new column and replace for cycle names. Not using this column for now. 
#sample_data(ps_18s_filt)$cycle_location <- sample_data(ps_18s_filt)$cycle
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "1", "C")
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "2", "D") 
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "5", "E") 
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "3", "A")
#sample_data(ps_18s_filt)$cycle_location = str_replace(sample_data(ps_18s_filt)$cycle_location, "4", "B")

sample_data(ps_18s_filt)$cycle_name_2 <- sample_data(ps_18s_filt)$cycle
sample_data(ps_18s_filt)$cycle_name_2 = str_replace(sample_data(ps_18s_filt)$cycle_name, "Cycle_1A", "SA1")
sample_data(ps_18s_filt)$cycle_name_2 = str_replace(sample_data(ps_18s_filt)$cycle_name, "Cycle_1B", "SA1")
sample_data(ps_18s_filt)$cycle_name_2 = str_replace(sample_data(ps_18s_filt)$cycle_name, "Cycle_1", "SA1")
sample_data(ps_18s_filt)$cycle_name_2 = str_replace(sample_data(ps_18s_filt)$cycle_name, "Cycle_2", "SA2") 
sample_data(ps_18s_filt)$cycle_name_2 = str_replace(sample_data(ps_18s_filt)$cycle_name, "Cycle_5", "SA3") 
sample_data(ps_18s_filt)$cycle_name_2 = str_replace(sample_data(ps_18s_filt)$cycle_name, "Cycle_3", "ST1")
sample_data(ps_18s_filt)$cycle_name_2 = str_replace(sample_data(ps_18s_filt)$cycle_name, "Cycle_4", "ST2")

sample_data(ps_18s_filt)$cycle_station <- str_c(sample_data(ps_18s_filt)$cycle_name_2, sample_data(ps_18s_filt)$station, sep ="_")

junk <- data.frame(ps_18s_filt@sam_data)

# Remove ASVs that are not present in the dataset
ps_18s_filt <- ps_18s_filt %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 

## Filtration based on taxonomy - remove metazoa and fungi
ps_18s_filt<- ps_18s_filt %>% 
    subset_taxa(!(supergroup %in% c("Opisthokonta")))%>%
    subset_taxa(!(division %in% c("Pseudofungi")))%>%
    subset_taxa(!(division %in% c("Metazoa", "Fungi"))) %>%
    subset_taxa(!(class == "Embryophyceae")) # to remove the plants.Likely from contamination. Checked with Adriana and Daniel, ok to remove.