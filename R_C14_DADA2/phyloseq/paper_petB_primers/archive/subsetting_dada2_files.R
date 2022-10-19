library(dplyr)
library(here)

dada2<-read.table(file = here("4.2_Ong_2022", "Ong_2022_dada2.tsv"), sep = '\t', header = TRUE) %>%
    filter(total_reads != 0)

write_tsv(dada2, here("4.2_Ong_2022", "Ong_2022_dada2_v2.tsv"), na="")


asv<-read.table(file = here("4.2_Ong_2022", "Ong_2022_asv.txt"), sep = '\t', header = TRUE) 

join <- left_join(asv,dada2) %>%
    select(asv_code:sequence_hash)
write_tsv(join, here("4.2_Ong_2022", "Ong_2022_asv_v2.txt"), na="")


seq_out <- Biostrings::DNAStringSet(dada2$sequence)
names(seq_out) <- str_c(dada2$asv_code,dada2$Subclade, sep="|") 

Biostrings::writeXStringSet(seq_out, here("4.2_Ong_2022","Ong_2022_taxo_v2.fasta"), 
                            compress=FALSE, width = 20000)
