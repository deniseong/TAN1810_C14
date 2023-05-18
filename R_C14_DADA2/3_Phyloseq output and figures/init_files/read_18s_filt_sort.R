#read merged phyloseq - asv set 47 processed by DV and dataset D4 processed by DO.
# contains all samples from TAN 1810 cruise from 2AM CTD filtered seawater samples, 18sv4 region.
ps_filt_sort<- read_rds(here("2.2_18SV4","phyloseq_merge_asv_set_47_Eukaryota_D4_filt_sort_seqhash.RDS"))

# ctd number U1938 replace with U9138, U1941 replace with U9141.
sample_data(ps_filt_sort)$ctd_cast = str_replace(sample_data(ps_filt_sort)$ctd_cast, "U1938", "U9138") #filt
sample_data(ps_filt_sort)$ctd_cast = str_replace(sample_data(ps_filt_sort)$ctd_cast, "U1941", "U9141") #sort


# Remove ASVs that are not present in the dataset
ps_filt_sort <- ps_filt_sort %>% 
    phyloseq::filter_taxa(function(x) sum(x) > 0 , TRUE) 

## Filtration based on taxonomy - remove metazoa and fungi
ps_filt_sort<- ps_filt_sort %>% 
    subset_taxa(!(supergroup %in% c("Opisthokonta")))%>%
    subset_taxa(!(division %in% c("Pseudofungi")))%>%
    subset_taxa(!(division %in% c("Metazoa", "Fungi"))) %>%
    subset_taxa(!(class == "Embryophyceae")) %>% # to remove the plants.Likely from contamination. Checked with Adriana and Daniel, ok to remove.
    subset_taxa(!(species == "Padina_australis")) %>%
    subset_taxa(!(class %in% c("Syndiniales")))

junk <- data.frame(ps_filt_sort@sam_data)
# junk <- data.frame(ps_filt_sort@otu_table)    
