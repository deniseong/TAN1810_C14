# Parameters for petB nested PCR.

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

# Need to change
dataset_code <- "petB_Denise primer"
dataset_id <- "D2"

# Path to dataset used. Using the Farrant Dore dataset.
database_path <- "databases/Farrant_database_noESTU.fasta"

# Define taxonomic levels based on the database. This will change between the petB and PR2 database.
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
  FWD = "TYCAGGACATYGCTGAY"
  REV = "GAAGTGCATGAGCATGAA"

  anchor = ""  # Put in front of primer to anchor primer at start of sequence
  
# parameters for filterAndTrim
  sequencer = "Illumina"


# Reduce the number of asvs for problematic cases
  max_number_asvs = 0

# parameters for removeBimeraDenovo
  method_chimera = "pooled"
  

  
  
  


