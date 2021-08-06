# Prerequisites
* Install R libraries
    library(dada2) # Must use version >= 1.12
    library(Biostrings)
    library(ShortRead)
    library(stringr)
    library(ggplot2)
    library(dplyr)
    library(tidyr)
    library(tibble)
    library(readr)
    library(purrr)
    library("optparse")  
- Install cutadapt (https://github.com/marcelm/cutadapt/releases)
- Download pr2 database (use dada2 file: https://github.com/pr2database/pr2database/releases)
- Copy all the compressed fastq files to a directory fastq inside dataset_path (see param_dada2_xx.R file) 
- xx corresponds to the dataset_id in the param_dada2_xx.R file  (e.g. "D1", "D2" etc... can choose)
- Everywhere below where you find xx, replace by dataset_id
- Edit parameters in param_dada2_xx.R file

# Run in test mode
Rscript --no-save --no-restore script_dada2.R -d xx -t > script_dada2_xx_test.out

# Examine the quality profiles
- Profiles are in subdirectory 'qual_pdf'
- Adapt parameters in param_file in particular 
        - truncLen
        - minLen

# Run the full analysis (probably one day for 200 samples)
Rscript --no-save --no-restore script_dada2.R -d xx > script_dada2_xx.out

