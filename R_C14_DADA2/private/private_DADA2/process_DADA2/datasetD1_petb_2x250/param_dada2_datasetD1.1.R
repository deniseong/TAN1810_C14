# Parameters for petB

# =================================
# Swtiches to adjust the processing
# =================================

  do_cutadapt     <- TRUE
  do_summary      <- TRUE
  do_plot_quality <- TRUE
  do_filtering <- TRUE # If TRUE and primers are present must also do_cutadapt = TRUE
  do_dada2    <- TRUE
  do_taxo <- TRUE
  multithread <- TRUE
  multithread_filter <- TRUE
  bigdata <- TRUE
  
# =================================
# Read the parameters 
# =================================

# Path to dataset used. Using the Farrant Dore dataset.
database_path <- "databases/Farrant_database_noESTU.fasta"

# Define taxonomic levels based on the database. This will change between the petB and PR2 database.
#tax_levels <- c("Domain", "Phylum", "Genus", "Sub_cluster", "Clade", "Subclade", "ESTU")
tax_levels <- c("Domain", "Phylum", "Genus", "Sub_cluster", "Clade", "Subclade")
# -- File structure

  paired_reads = TRUE
  
  file_identifier = ".fastq"  # String to identify the files to be processed.
  # must unzip the fastq.gz files to fastq
  R1_identifier = "_R1.fastq"
  R2_identifier = "_R2.fastq"
  file_name_separator = "_"
# This the first character of the file name to consider to extract the sample name (usually = 1)
#  sample.names_first_character =  1


# --  Other parameters
# target
#  gene = "18S"
#  gene_region = "V4"
#  organelle = "nucleus"

gene = "petB"
gene_region = "petB"
organelle = "nucleus"

# Need to change
# primer sets (petB-29F TYCAGGACATYGCTGAY petB-R GAAGTGCATGAGCATGAA)
# Only 50% of reads used because alternate directions
#  FWD = "TYCAGGACATYGCTGAY"
#  REV = "GAAGTGCATGAGCATGAA"

  #Primer sets (petB-F and petB-R)
  FWD = "TACGACTGGTTCCAGGAACG"
  REV = "GAAGTGCATGAGCATGAA"
  
  anchor = ""  # Put in front of primer to anchor primer at start of sequence
  
# parameters for filterAndTrim
  sequencer = "Illumina"

# parameters for filterAndTrim
# for the nested petB, the total length including primer is 571bp
# total length without the primer is 534bp. need at least 12 bp overlap.
# Need to change as a function of testiing
#  truncLen = c(273,273) # This influences the number of ASVs and the percent of asv recovered (need to remove 20 and 21)
#  minLen = c(273,273)
#  truncQ = 2         
#  maxEE = c(2, 2) 
#  maxLen = 400  # This is for 454 to remove long and bad reads
# need to trim as the sequencing quality drops off at the end of reads. 
# Reduce the number of asvs for problematic cases
  max_number_asvs = 0

# parameters for removeBimeraDenovo
  method_chimera = "pooled"





