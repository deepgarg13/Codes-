library(QuasR)
library(BCProcessedReads)

# obtain a list of fastq file paths
fastqFiles = system.file(package = "BCProcessedReads", "extdata", c("FASTQ_FILE_NAME"))
path = ("WORKING_DIRECTORY_LOCATION")
setwd(path)

# defined processed fastq file names
outfiles <- paste(tempfile(pattern = c("processed_4_"), tmpdir = gsub('\\/$', '', path)), ".fastq", sep = "")

# process fastq files
# Remove Adapter patern if it occurs at the start (Lpattern)
preprocessReads(fastqFiles, outfiles, nBases=1, Lpattern="ADAPTER_SEQUENCE")