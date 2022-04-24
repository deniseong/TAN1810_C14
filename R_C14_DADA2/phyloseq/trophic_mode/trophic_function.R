# Function for trophic allocation
# 2 columns. trophic_mode with 4 categories(photosynthetic, mixotrophic, heterotrophic, syndiniales), and trophic_mode_2 separating dinophyceae.
phyloseq_assign_trophic <- function(ps) {
    
    otus <- data.frame(otu_table(ps))
    taxa <- data.frame(tax_table(ps))
    samples <- data.frame(sample_data(ps))
    
    # Load the file that assign trophic mode to every PR2 
    pr2_trophic <- readxl::read_excel(here("phyloseq", "trophic_mode", "pr2_trophic.xlsx"), sheet="with trophic") %>%
        select(species, taxon_level, trophic_mode) %>%
        mutate(trophic_mode = recode(trophic_mode, phytoplankton = "photosynthetic",
                             mixoplankton = "mixotrophic",
                             protozooplankton = "heterotrophic"))
    
    #preserve ASV before merging
    taxa$asv_code <-rownames(taxa)
    
    #Add trophic_mode and the level at which it was assigned (taxon_level) into the taxa table
    taxa<-left_join(taxa,pr2_trophic,by="species")
    
    #Separating Syndinales as Syndinales
    taxa$trophic_mode <- ifelse(taxa$class=="Syndiniales","syndiniales",taxa$trophic_mode)
    
    # create a new column for trophic mode, separate dinophyceae
    taxa$trophic_mode_2 <- taxa$trophic_mode
    taxa$trophic_mode_2<-ifelse(taxa$class=="Dinophyceae","dinophyceae",taxa$trophic_mode_2)

    #put ASV back as taxa's rowname
    row.names(taxa)<-taxa$asv_code
    
    #remove asv column since it's already rowname
    taxa$asv_code<-NULL
    
    #rename column for otus, to replace . with _
    otus <- otus %>%
        rename_all(funs(stringr::str_replace_all(., '\\.', '-')))
    
    # merge otus, taxa and samples table to form phyloseq object
    otus <- as.matrix(otus)
    taxa <- as.matrix(taxa)
    
    otus= otu_table(otus, taxa_are_rows = TRUE)
    taxa = tax_table(taxa)
    samples = sample_data(samples)
    ps <- merge_phyloseq(otus, taxa, samples)
    
    return(ps)
}
