# The directories listed is for petB Denise primers, merged testing.
# This test is for checking if chim removal changes composition of the assignment. because losing too many reads at the chimera removal option.
#settled using the filter and trim options and using just concatenate function and assign taxonomy function. 
# Checking the percentage similarity of subclade output between different output, and subclade composition.

dir_fastq <- "/Volumes/Denise/C14_DADA2/fastq_petb_2x300/fastq_petb_Denise_subset"  # fastq directory
# using the samples: CTD-NpetB-138, CTD-NpetB-139, syn-68, syn-69

# set output to harddrive
dir_fastqN <-  "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v5/fastqN/"  # for filtered files removing reads with N
dir_cutadapt <- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v5/cutadapt/" # files after cutadapt
dir_filtered<- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v5/filtered/"  # fastq filtered
#dir_vsearch <- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v3/vsearch_merged/" #R1 and R2 reads merged with vsearch

# set output to github
dir_qual <- "output_petb_2x300/output_petb_Denise_testing/testing_v5/qual_pdf/"  # qual pdf
#dir_petb <- "output_petb_2x300/output_petb_nested/petb_results/"  # petb results
#dir_blast <- "output_petb_2x300/output_petb_nested/blast_results/"  # blast2 results

# Only create directories below once.
dir.create(dir_filtered)
dir.create(dir_qual)
#dir.create(dir_petb)
#dir.create(dir_blast)
dir.create(dir_fastqN)
dir.create(dir_cutadapt)
#dir.create(dir_vsearch)

output_path <- function(file_end)  str_c("output_petb_2x300/output_petb_Denise_testing/testing_v5/", dataset_code, file_end)

# parameters for filterAndTrim
# for the nested petB, the total length including primer is 571bp
# total length without the primer is 534bp. need at least 12 bp overlap.
truncLen = c(250, 280) # truncate reads to the length
minLen = c(250, 280) #remove reads that are shorter.
truncQ = 2      # Truncate reads at the first instance of a quality score less than or equal to truncQ
maxEE = c(10, 10) #after truncation, reads with higher than expected errors are discarded. 

# For phyloseq object - import sample table
sample <- readxl::read_excel("sample_list/sampleList_sorted_syn.xlsx")
sample <- readxl::read_excel("sample_list/sampleList_CTD_petB_nested.xlsx")
