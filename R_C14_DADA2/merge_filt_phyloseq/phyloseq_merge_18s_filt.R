# Create new phyloseq by merging output from sediment trap phyloseq and from sorted samples processing

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

#changing names of few columns to merge
ps_18s_filt_2 <-  subset_samples(ps_18s_filt_1, sample == "water_CTD")
sample_data(ps_18s_filt_2)$cycle <- sample_data(ps_18s_filt_2)$station_set
sample_data(ps_18s_filt_2)$ctd_cast <- sample_data(ps_18s_filt_2)$metadata_remark
sample_data(ps_18s_filt_2)$station <- sample_data(ps_18s_filt_2)$station_id

sample_data(ps_18s_filt)$metadata_code <- sample_data(ps_18s_filt)$sample_name_old
sample_data(ps_18s_filt)$cycle = str_replace(sample_data(ps_18s_filt)$cycle, "1", "Cycle_1")

ps_filt_merge <- merge_phyloseq(ps_18s_filt,ps_18s_filt_2)

#cycle_station
sample_data(ps_filt_merge)$cycle_station <- str_c(sample_data(ps_filt_merge)$cycle, sample_data(ps_filt_merge)$station, sep ="_")

#copy the column of interest to create new column, and replacing names for water masses SA and ST
sample_data(ps_filt_merge)$water_mass <- sample_data(ps_filt_merge)$cycle
sample_data(ps_filt_merge)$water_mass = str_replace(sample_data(ps_filt_merge)$water_mass, "Cycle_1|Cycle_1A|Cycle_1B|Cycle_2|Cycle_5", "SA") 
sample_data(ps_filt_merge)$water_mass = str_replace(sample_data(ps_filt_merge)$water_mass, "Cycle_3|Cycle_4", "ST")

#export sample table to manually change depth from "5" to "05", and add depth category from 1-6
sample <- data.frame(ps_filt_merge@sam_data)
junk$sample <-rownames(sample)
writexl::write_xlsx(sample, "ps_filt_merge_sample.xlsx")
junk2<- data.frame(ps_filt_merge@tax_table)

#reimport the edited sample table, merge into the new phyloseq.
sample_2<-  readxl::read_excel("ps_filt_merge_sample.xlsx")
otus <- data.frame(otu_table(ps_filt_merge))
taxa <- data.frame(tax_table(ps_filt_merge))

#rename column for otus, to replace . with _
otus <- otus %>%
    rename_all(funs(stringr::str_replace_all(., '\\.', '-')))

row.names(sample_2)<-sample_2$sample_name

# merge otus, taxa and samples table to form phyloseq object
otus <- as.matrix(otus)
taxa <- as.matrix(taxa)

otus= otu_table(otus, taxa_are_rows = TRUE)
taxa = tax_table(taxa)
sample_2 = sample_data(sample_2)
ps <- merge_phyloseq(otus, taxa, sample_2)

saveRDS(ps, "phyloseq_merge_asv_set_47_Eukaryota_D4_filt.RDS")

