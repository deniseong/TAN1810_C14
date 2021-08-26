# Denise edits- For nested petB

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
dataset_code <- "TAN1810_petB_nested"
dataset_id <- "D1"

# Need to change - All fastq files should be in a subdirectory called /fastq
dataset_path <- "fastq_petB_nested"
#pr2_file <- "/pr2_version_4.12.0_18S_dada2.fasta.gz" 
#for petB not using the pr2 file. Using the Farrant Dore dataset.
petb_file <- "databases/Farrant_database_noESTU.fasta"


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

# parameters for filterAndTrim
# for the nested petB, the total length including primer is 571bp
# Need to change as a function of testiing
  truncLen = c(230,210) # This influences the number of ASVs and the percent of asv recovered (need to remove 20 and 21)
  minLen = c(230,210)
  truncQ = 2         
  maxEE = c(10, 10) 
  maxLen = 400  # This is for 454 to remove long and bad reads

# Reduce the number of asvs for problematic cases
  max_number_asvs = 0

# parameters for removeBimeraDenovo
  method_chimera = "pooled"





