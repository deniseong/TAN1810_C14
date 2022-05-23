# Create new phyloseq by merging output from sediment trap phyloseq and from sorted samples processing

#### First with sediment trap phyloseq - asv set 47 ####
# from sediment trap phyloseq- subset only CTD samples
ps_18s_filt_1<- read_rds(here("merge_filt_phyloseq", "metapr2_phyloseq_asv_set_47_Eukaryota.rds"))

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
ps_18s_filt_1 <-  subset_samples(ps_18s_filt_1, sample == "water_CTD")
sample_data(ps_18s_filt_1)$cycle <- sample_data(ps_18s_filt_1)$station_set
sample_data(ps_18s_filt_1)$ctd_cast <- sample_data(ps_18s_filt_1)$metadata_remark
sample_data(ps_18s_filt_1)$station <- sample_data(ps_18s_filt_1)$station_id

#extract asv table, change to sequence hash instead of asv number
sample <- data.frame(ps_18s_filt_1@sam_data)
otus <- data.frame(ps_18s_filt_1@otu_table)
taxa <- data.frame(ps_18s_filt_1@tax_table)

#rename column for otus, to replace . with _
otus <- otus %>%
    rename_all(funs(stringr::str_replace_all(., '\\.', '-'))) 

#read excel with sequence hash data
seq_hash <- readxl::read_excel(here("merge_filt_phyloseq", "metapr2_asv_set_47_Eukaryota copy.xlsx")) %>%
    select(seq_name, sequence_hash)
taxa$seq_name <-rownames(taxa) #preserve ASV before merging
taxa<- full_join(taxa, seq_hash) #merge for seq_hash
row.names(taxa) <- taxa$sequence_hash
taxa <- taxa %>%
    select(-seq_name, -sequence_hash) 

otus$seq_name <- rownames(otus)
otus<- full_join(otus, seq_hash) #merge for seq_hash
row.names(otus) <- otus$sequence_hash
otus <- otus %>%
    select(-seq_name, -sequence_hash) 
    

# merge otus, taxa and samples table to form phyloseq object
otus <- as.matrix(otus)
taxa <- as.matrix(taxa)

otus= otu_table(otus, taxa_are_rows = TRUE)
taxa = tax_table(taxa)
sample = sample_data(sample)
ps_18s_filt_1_edit <- merge_phyloseq(otus, taxa, sample)

#### From sorted sample sequencing - dataset ID D4 ####
# Load the phyloseq files - from Denise processing
ps_18s_filt<- read_rds(here("output_18SV4", "TAN1810_18SV4phyloseq_CTD_18SV4.RDS"))

sample_data(ps_18s_filt)$metadata_code <- sample_data(ps_18s_filt)$sample_name_old
sample_data(ps_18s_filt)$cycle = str_replace(sample_data(ps_18s_filt)$cycle, "1", "Cycle_1")

#extract asv table, change to sequence hash instead of asv number
sample <- data.frame(ps_18s_filt@sam_data)
otus <- data.frame(ps_18s_filt@otu_table)
taxa <- data.frame(ps_18s_filt@tax_table)

#rename column for otus, to replace . with _
otus <- otus %>%
    rename_all(funs(stringr::str_replace_all(., '\\.', '-'))) 

#read excel with sequence hash data
seq_hash <- readxl::read_excel(here("output_18SV4", "TAN1810_18SV4_metapr2_asv.xlsx")) %>%
    select(asv_code, sequence_hash) %>%
    rename(seq_name = asv_code)

taxa$seq_name <-rownames(taxa) #preserve ASV before merging
taxa<- left_join(taxa, seq_hash) #merge for seq_hash
row.names(taxa) <- taxa$sequence_hash
taxa <- taxa %>%
    select(-seq_name, -sequence_hash) 

otus$seq_name <- rownames(otus)
otus<- left_join(otus, seq_hash) #merge for seq_hash
row.names(otus) <- otus$sequence_hash
otus <- otus %>%
    select(-seq_name, -sequence_hash) 


# merge otus, taxa and samples table to form phyloseq object
otus <- as.matrix(otus)
taxa <- as.matrix(taxa)

otus= otu_table(otus, taxa_are_rows = TRUE)
taxa = tax_table(taxa)
sample = sample_data(sample)
ps_18s_filt_edit <- merge_phyloseq(otus, taxa, sample)


#### merge the two phyloseq by sequence_hash ####
ps_filt_merge <- merge_phyloseq(ps_18s_filt_edit,ps_18s_filt_1_edit)

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
sample_2<-  readxl::read_excel(here("merge_filt_phyloseq", "ps_filt_merge_sample.xlsx"))
otus <- data.frame(otu_table(ps_filt_merge))
taxa <- data.frame(tax_table(ps_filt_merge))

#rename column for otus, to replace . with _
otus <- otus %>%
    rename_all(funs(stringr::str_replace_all(., '\\.', '-')))

rownames(sample_2)<-sample_2$sample_name

# merge otus, taxa and samples table to form phyloseq object
otus <- as.matrix(otus)
taxa <- as.matrix(taxa)

otus= otu_table(otus, taxa_are_rows = TRUE)
taxa = tax_table(taxa)
sample_2 = sample_data(sample_2)
rownames(sample_2)<-sample_2$sample_name

ps <- merge_phyloseq(otus, taxa, sample_2)

saveRDS(ps, "phyloseq_merge_asv_set_47_Eukaryota_D4_filt_seqhash.RDS")
