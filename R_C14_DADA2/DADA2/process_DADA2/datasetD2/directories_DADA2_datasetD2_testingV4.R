# The directories listed is for petB Denise primers, merged testing.
#Testing with justconcantetate option similar to testing_V2, but changing the filter and trim option to check if can reduce the ASV lost to chimera.
#Also tested using justconcentate option with mergePairs function, seems to assign well as all reads were assigned as Synechococcus.
#Previous settings in testing_v2 was ok until chimera removal, where about half of the seq were removed. Unable to scale up for all the samples, because takes too long to run. Trying to change the filter and trim so that the chimeras are reduced.
#DADA2 tutorial says that most reads should retain during chimera removal, if not need to change upstream processing before DADA2 pipeline.

# Testing to cut R1 and R2 at the same length. V2 and v3 produced too many ASVs, could be due to the difference in length.
# Will try to cut at 200 and 250 to see the differences.

dir_fastq <- "/Volumes/Denise/C14_DADA2/fastq_petb_2x300/fastq_petb_Denise_subset"  # fastq directory
# using the samples: CTD-NpetB-138, CTD-NpetB-139, syn-68, syn-69

# set output to harddrive
dir_fastqN <-  "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v4/fastqN/"  # for filtered files removing reads with N
dir_cutadapt <- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v4/cutadapt/" # files after cutadapt
dir_filtered<- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v4/filtered/"  # fastq filtered
#dir_vsearch <- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Denise_testing/testing_v3/vsearch_merged/" #R1 and R2 reads merged with vsearch

# set output to github
dir_qual <- "output_petb_2x300/output_petb_Denise_testing/testing_v4/qual_pdf/"  # qual pdf
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

output_path <- function(file_end)  str_c("output_petb_2x300/output_petb_Denise_testing/testing_v4/", dataset_code, file_end)

# parameters for filterAndTrim
# for the nested petB, the total length including primer is 571bp
# total length without the primer is 534bp. need at least 12 bp overlap.
truncLen = c(250, 270) # truncate reads to the length
minLen = c(250, 270) #remove reads that are shorter.
truncQ = 2      # Truncate reads at the first instance of a quality score less than or equal to truncQ
maxEE = c(10, 20) #after truncation, reads with higher than expected errors are discarded. 

# For phyloseq object - import sample table
sample <- readxl::read_excel("sample_list/sampleList_sorted_syn.xlsx")
#sample <- readxl::read_excel("sample_list/sampleList_CTD_petB_nested.xlsx")