# Create new phyloseq by merging filt and sorted phyloseq

#load sorted pico and nano
source(here("phyloseq", "init_files", "read_pico.R"))
source(here("phyloseq", "init_files", "read_nano.R"))

#merge sorted pico and nano ps, because they have the same ASV code
ps_sort_merge<- merge_phyloseq(ps_pico, ps_nano)

#extract asv table, change to sequence hash instead of asv number
sample <- data.frame(ps_sort_merge@sam_data)
otus <- data.frame(ps_sort_merge@otu_table)
taxa <- data.frame(ps_sort_merge@tax_table)

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

sample <- sample %>%
    #select(STN, SAMPLE,DEPTH, vial, sorting_population, sample_name, cycle_name_2) %>%
    rename(station = STN,
           sample = SAMPLE,
           depth = DEPTH,
           sample_type = sorting_population)

# merge otus, taxa and samples table to form phyloseq object
otus <- as.matrix(otus)
taxa <- as.matrix(taxa)

otus= otu_table(otus, taxa_are_rows = TRUE)
taxa = tax_table(taxa)
sample = sample_data(sample)
ps_18s_sort_edit <- merge_phyloseq(otus, taxa, sample)


#load filt phyloseq, already merged by seq hash
source(here("phyloseq", "init_files", "read_18s_filt.R"))

sample <- data.frame(ps_18s_filt@sam_data) %>%
    #select(cycle, station, depth, depth_category, sample_name) %>%
    mutate(cycle_name_2 = recode(cycle, "Cycle_1" = "SA1",
                               "Cycle_1A" = "SA1",
                               "Cycle_1B" = "SA1",
                               "Cycle_2" = "SA2",
                               "Cycle_3" = "ST1",
                               "Cycle_4" = "ST2",
                               "Cycle_5" = "SA3")) %>%
    mutate(sample = recode(depth_category, "2" = "SUR",
                           "5" = "DCM"))
sample$sample_type <- "filt"

#extract asv table, change to sequence hash instead of asv number
otus <- data.frame(ps_18s_filt@otu_table)
taxa <- data.frame(ps_18s_filt@tax_table)

#rename column for otus, to replace . with _
otus <- otus %>%
    rename_all(funs(stringr::str_replace_all(., '\\.', '-'))) 

# merge otus, taxa and samples table to form phyloseq object
otus <- as.matrix(otus)
taxa <- as.matrix(taxa)

otus= otu_table(otus, taxa_are_rows = TRUE)
taxa = tax_table(taxa)
sample = sample_data(sample)
ps_18s_filt_edit <- merge_phyloseq(otus, taxa, sample)

ps_sort_filt<- merge_phyloseq(ps_18s_filt_edit, ps_18s_sort_edit)

saveRDS(ps_sort_filt, here("merge_filt_phyloseq", "phyloseq_merge_asv_set_47_Eukaryota_D4_filt_sort_seqhash.RDS"))
