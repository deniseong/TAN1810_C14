# Read and edit syn database fasta file. To change the sequence name to the taxonomic levels in the excel sheet. 

# Load libraries
library(Biostrings) #to read fasta
library(stringr)
library(readxl)
library(dplyr)
library(tidyr)
library(phylotools) #to export fasta

## Read fasta file as data frame

fasta_file <- readDNAStringSet("databases/petB_721_FIXED_715_seqs_ShortName_FullLength.fasta")
seq_name <- names(fasta_file)
sequence <- paste(fasta_file)
seq_fasta <- data.frame(seq_name, sequence) %>% #edit sequence name to match 
    separate(seq_name, c("seq_name","junk"), "_") %>% #note: initially used str_split but cannot join later. Not sure why because the names seem to be ok
    select(-junk)

### Change a few seq_name to match corresponding name in the excel sheet
seq_fasta$seq_name <- str_replace(seq_fasta$seq_name, "A18-14-154m", "A1814-154m")
seq_fasta$seq_name <- str_replace(seq_fasta$seq_name, "A18-14b-surf", "A1814b-surf")
seq_fasta$seq_name <- str_replace(seq_fasta$seq_name, "77-2", "772")

## Read excel with taxonomic levels
database_excel<- readxl::read_excel("databases/Farrant Dore et al_Dataset_corrected.xlsx", sheet = "dataset1", skip = 1)
tax_name <- database_excel %>%
    dplyr::select(`Strain or environmental sequence ID`:`ESTU`) %>%
    dplyr::rename(seq_name = `Strain or environmental sequence ID`,
           Sub_cluster = `Sub cluster`)

### Neaten names
tax_name$Phylum <- str_replace(tax_name$Phylum, "Cya", "Cyanobacteria")
tax_name$Genus <- str_replace(tax_name$Genus, "Pro", "Prochlorococcus")
tax_name$Genus <- str_replace(tax_name$Genus, "Syn", "Synechococcus")
tax_name$Domain <- tax_name$Phylum #Copy Phylum column and add Domain
tax_name$Domain <- str_replace(tax_name$Domain, "Cyanobacteria", "Prokaryota")
tax_name <- tax_name %>%
    relocate(Domain, .after = seq_name) # arrage the columns

## merge and check unassigned sequences/taxonomic groups. There are a few for each.
check_all <- full_join(tax_name, seq_fasta, by = "seq_name")  #checking
check_seq <- check_all %>%
    filter(is.na(sequence)) #checking
check_tax <- check_all %>%
    filter(is.na(Phylum)) #checking
tax_seq <- check_all %>%
    filter(!is.na(sequence)) # the working table

## Select for empty rows in subcluster column, to fill with value from Genus column.

tax_seq_sub <- tax_seq %>%
    filter(is.na(Sub_cluster)) %>% #First to subset the empty rows in Subcluster column
    select(-Sub_cluster) %>% #Remove the column
    mutate(Sub_cluster = Genus) %>% #Copy Genus column over
    relocate(Sub_cluster, .after = Genus)
tax_seq_sub2 <- tax_seq %>%
    filter(!is.na(Sub_cluster)) #Filter out the rest of the columns

tax_seq <- merge(tax_seq_sub, tax_seq_sub2, all = TRUE) #Merge the two dataframes again

## To remove unassigned sequences and seq_name col
tax_seq_ESTU <- tax_seq %>%
    filter(!is.na(Domain)) %>% #remove unassigned sequences
    select(-seq_name) #remove seq_name column
tax_seq_noESTU <- tax_seq_ESTU %>%
    select(-ESTU) #Remove ESTU

#Fasta for each subclade to check similarity
#tax_seq_Ia <- tax_seq_noESTU %>%
#    filter(Subclade =="Ia")
#tax_seq_out_Ia <- Biostrings::DNAStringSet(tax_seq_Ia$sequence)
#names(tax_seq_out_Ia) <- tax_seq_Ia$Subclade
#Biostrings::writeXStringSet(tax_seq_out_Ia, output_path("_FARRANT_taxo_Ia.fasta"), 
#                            compress=FALSE, width = 20000)


## First combine taxonomic levels into one column
tax_seq_ESTU$ESTU <- str_replace_na(tax_seq_ESTU$ESTU)
tax_seq_ESTU <- tax_seq_ESTU %>%
    unite("tax", Domain:ESTU, sep = ";", remove = TRUE)  #using tidyr
tax_seq_noESTU <- tax_seq_noESTU %>%
    unite("tax", Domain:Subclade, sep = ";", remove = TRUE)

## Export as fasta
dataframe2fas(tax_seq_ESTU, file = "databases/Farrant_database_ESTU.fasta")
dataframe2fas(tax_seq_noESTU, file = "databases/Farrant_database_noESTU.fasta")

## Export another fasta for unassigned sequences
unassigned <- tax_seq %>%
    filter(is.na(Domain)) %>%
    select(seq_name, sequence)
dataframe2fas(unassigned, file = "databases/Farrant_database_unassigned.fasta")
