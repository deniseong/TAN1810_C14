# The directories listed is for the CTD petB nested unpaired R1.

# Need to change
dataset_code <- "TAN1810_CTD_nested"
dataset_id <- "D1.2"

dir_fastq <- "fastq_petb_2x250/fastq_CTD_petB_nested"  # fastq directory

dir_fastqN <-  "output_petb_2x250/output_CTD_petB_nested_R1/fastqN/"  # for filtered files removing reads with N
dir_cutadapt <- "output_petb_2x250/output_CTD_petB_nested_R1/cutadapt/" # files after cutadapt

dir_filtered<- "output_petb_2x250/output_CTD_petB_nested_R1/filtered/"  # fastq filtered
dir_qual <- "output_petb_2x250/output_CTD_petB_nested_R1/qual_pdf/"  # qual pdf
dir_petb <- "output_petb_2x250/output_CTD_petB_nested_R1/petb_results/"  # petb results
dir_blast <- "output_petb_2x250/output_CTD_petB_nested_R1/blast_results/"  # blast2 results

# Only create directories below once.
dir.create(dir_filtered)
dir.create(dir_qual)
dir.create(dir_petb)
dir.create(dir_blast)
dir.create(dir_fastqN)
dir.create(dir_cutadapt)

output_path <- function(file_end)  str_c("output_petb_2x250/output_CTD_petB_nested_R1/", dataset_code, file_end)

# For phyloseq object - import sample table
sample <- readxl::read_excel("sample_list/sampleList_CTD_petB_nested.xlsx")