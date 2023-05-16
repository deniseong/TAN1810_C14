# The directories listed is for petB Denise primers, merged testing
# Initially used to Test_mergeV2.Rmd, using vsearch, but the idea is similar to using justconcentate option with mergePairs function. So testing with the option on DADA2_paired.
# seems to assign well as all reads were assigned as Synechococcus.

dir_fastq <- "/Volumes/Denise/C14_DADA2/fastq_petb_2x300/fastq_petb_Denise_subset"  # fastq directory
# using the samples: CTD-NpetB-138, CTD-NpetB-139, syn-68, syn-69

# set output to harddrive
dir_fastqN <-  "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v2/fastqN/"  # for filtered files removing reads with N
dir_cutadapt <- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v2/cutadapt/" # files after cutadapt
dir_filtered<- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v2/filtered/"  # fastq filtered
dir_vsearch <- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v2/vsearch_merged/" #R1 and R2 reads merged with vsearch
# set output to github
dir_qual <- "output_petb_2x300/output_petb_Denise_testing/testing_v2/qual_pdf/"  # qual pdf
#dir_petb <- "output_petb_2x300/output_petb_nested/petb_results/"  # petb results
#dir_blast <- "output_petb_2x300/output_petb_nested/blast_results/"  # blast2 results

# Only create directories below once.
dir.create(dir_filtered)
dir.create(dir_qual)
#dir.create(dir_petb)
#dir.create(dir_blast)
dir.create(dir_fastqN)
dir.create(dir_cutadapt)
dir.create(dir_vsearch)

output_path <- function(file_end)  str_c("output_petb_2x300/output_petb_Denise_testing/testing_v2/", dataset_code, file_end)

# parameters for filterAndTrim
# for the nested petB, the total length including primer is 571bp
# total length without the primer is 534bp. need at least 12 bp overlap.
 truncLen = c(250,280) # This influences the number of ASVs and the percent of asv recovered (need to remove 20 and 21). 
 minLen = c(250, 280) #remove reads that are shorter.
 truncQ = 2         # Truncate reads at the first instance of a quality score less than or equal to truncQ
 maxEE = c(10, 10) #after truncation, reads with higher than expected errors are discarded. 

# For phyloseq object - import sample table
sample <- readxl::read_excel("sample_list/sampleList_sorted_syn.xlsx")
#sample <- readxl::read_excel("sample_list/sampleList_CTD_petB_nested.xlsx")