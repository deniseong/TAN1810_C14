# The directories listed is for petB Mazard primer, testing for merge

dir_fastq <- "/Volumes/Denise/C14_DADA2/fastq_petb_2x300/fastq_petb_Mazard_subset"  # fastq directory

# set output to harddrive
dir_fastqN <-  "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Mazard_testing/merge_v1/fastqN/"  # for filtered files removing reads with N
dir_cutadapt <- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Mazard_testing/merge_v1/cutadapt/" # files after cutadapt
dir_filtered<- "/Volumes/Denise/C14_DADA2/output_petb_2x300/output_petb_Mazard_testing/merge_v1/filtered/"  # fastq filtered

# set output to github
dir_qual <- "output_petb_2x300/output_petb_Mazard_testing/merge_v1/qual_pdf/"  # qual pdf

# Only create directories below once.
dir.create(dir_filtered)
dir.create(dir_qual)
dir.create(dir_fastqN)
dir.create(dir_cutadapt)

output_path <- function(file_end)  str_c("output_petb_2x300/output_petb_Mazard_testing/merge_v1/", dataset_code, file_end)

# For phyloseq object - import sample table
sample <- readxl::read_excel("sample_list/sampleList_CTD_petB_normal.xlsx")

#Filter and trim - edit the parameters
truncLen = c(280) # This influences the number of ASVs and the percent of asv recovered (need to remove 20 and 21). 
minLen = c(280) #remove reads that are shorter.
truncQ = 2         
maxEE = c(10) #after truncation, reads with higher than expected errors are discarded. 