# The directories listed is for petB F29/R, merged testing.

dir_fastq <- "/Volumes/Denise/C14_DADA2/fastq_petb_2x300/fastq_petb_nested_subset"  # fastq directory
# using the samples: CTD-NpetB-138, CTD-NpetB-139, syn-68, syn-69

# set output to harddrive
dir_fastqN <-  "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_nested_testing/merged/fastqN/"  # for filtered files removing reads with N
dir_cutadapt <- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_nested_testing/merged/cutadapt/" # files after cutadapt
dir_filtered<- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_nested_testing/merged/filtered/"  # fastq filtered

# set output to github
dir_qual <- "output_petb_2x300/output_petb_nested_testing/merged/qual_pdf/"  # qual pdf
#dir_petb <- "output_petb_2x300/output_petb_nested/petb_results/"  # petb results
#dir_blast <- "output_petb_2x300/output_petb_nested/blast_results/"  # blast2 results

# Only create directories below once.
dir.create(dir_filtered)
dir.create(dir_qual)
#dir.create(dir_petb)
#dir.create(dir_blast)
dir.create(dir_fastqN)
dir.create(dir_cutadapt)

output_path <- function(file_end)  str_c("output_petb_2x300/output_petb_nested_testing/merged/", dataset_code, file_end)

# For phyloseq object - import sample table
#sample <- readxl::read_excel("sample_list/sampleList_sorted_syn.xlsx")
#sample <- readxl::read_excel("sample_list/sampleList_CTD_petB_nested.xlsx")