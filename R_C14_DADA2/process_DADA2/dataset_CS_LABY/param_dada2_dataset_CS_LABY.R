# Parameters for LABY 18SV4

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
dataset_code <- "CS_LABY"
dataset_id <- "D6"

# Path to dataset used. Using the Farrant Dore dataset.
database_path <- "databases/pr2_version_4.14.0_SSU_dada2.fasta.gz"

# Define taxonomic levels based on the database. This will change between the petB and PR2 database.
tax_levels <- c("kingdom", "supergroup","division", "class", "order", "family", "genus", "species")

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
  gene = "18S"
  gene_region = "V4"
  organelle = "nucleus"


  # Need to change
  # primer sets (LABY-A LABY-Y) 
  # Only 50% of reads used because alternate directions
  FWD = "GGGATCGAAGATGATTAG"
  REV = "CWCRAACTTCCTTCCGGT"

  anchor = ""  # Put in front of primer to anchor primer at start of sequence
  
# parameters for filterAndTrim
  sequencer = "Illumina"


# Reduce the number of asvs for problematic cases
  max_number_asvs = 0

# parameters for removeBimeraDenovo
  method_chimera = "pooled"
  
  # parameters for filterAndTrim
  # Need to change as a function of testiing
  truncLen = c(220,210) # This influences the number of ASVs and the percent of asv recovered (need to remove 20 and 21)
  minLen = c(220,210)
  truncQ = 2         
  maxEE = c(10, 10) 
#  maxLen = 400  # This is for 454 to remove long and bad reads
  


