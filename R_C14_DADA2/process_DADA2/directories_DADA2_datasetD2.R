# The directories listed is for petB nested.

dir_fastq <- "fastq_petb_2x300/fastq_petb_nested"  # fastq directory

dir_fastqN <-  "output_petb_2x300/output_petb_nested/fastqN/"  # for filtered files removing reads with N
dir_cutadapt <- "output_petb_2x300/output_petb_nested/cutadapt/" # files after cutadapt

dir_filtered<- "output_petb_2x300/output_petb_nested/filtered/"  # fastq filtered
dir_qual <- "output_petb_2x300/output_petb_nested/qual_pdf/"  # qual pdf
dir_petb <- "output_petb_2x300/output_petb_nested/petb_results/"  # petb results
dir_blast <- "output_petb_2x300/output_petb_nested/blast_results/"  # blast2 results

# Only create directories below once.
dir.create(dir_filtered)
dir.create(dir_qual)
dir.create(dir_petb)
dir.create(dir_blast)
dir.create(dir_fastqN)
dir.create(dir_cutadapt)

output_path <- function(file_end)  str_c("output_petb_2x300/output_petb_nested/", dataset_code, file_end)

# For phyloseq object - import sample table
sample <- readxl::read_excel("sample_list/sampleList_sorted_syn.xlsx")
sample <- readxl::read_excel("sample_list/sampleList_CTD_petB_nested.xlsx")
