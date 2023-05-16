# The directories listed is for 18SV4.

#set filepath for directories
dir_fastq <- "CS_18S"  # fastq directory

## set output to harddrive
dir_fastqN <-  "output_CS/18S/fastqN/"  # for filtered files removing reads with N
dir_cutadapt <- "output_CS/18S/cutadapt/" # files after cutadapt
dir_filtered<- "output_CS/18S/filtered/"  # fastq filtered

## set output to github
dir_qual <- "output_CS/18S/qual_pdf/"  # qual pdf

# Only create directories below once.
dir.create(dir_filtered)
dir.create(dir_qual)
#dir.create(dir_petb)
#dir.create(dir_blast)
dir.create(dir_fastqN)
dir.create(dir_cutadapt)

#create function to set file output path
output_path <- function(file_end)  str_c("output_CS/18S/", dataset_code, file_end)

# For phyloseq object - import sample table
#sample <- readxl::read_excel("sample_list/sampleList_CTD_petB_normal.xlsx")