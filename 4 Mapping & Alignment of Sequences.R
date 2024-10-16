library(QuasR)
library(ShortRead)
library(Rqc)
library(PACKAGE_NAME)

# copy example data to current working directory
folder = system.file(package="PACKAGE_NAME", "extdata")
filenames <- list.files(folder)[grepl('*.fastq.gz', list.files(folder))]

SRR_aligned_txt <- cbind(filenames, paste0('Sample', rep(1:length(filenames))))
colnames(SRR_aligned_txt) <- c('FileName', 'SampleName')
write.table(SRR_aligned_txt, 'SRR_aligned_txt.txt', col.names = T, quote = F, row.names = F, sep = "\t")

file.copy(system.file(package="PACKAGE_NAME", "extdata"), ".", recursive=TRUE)

# genome file in fasta format
genomeFile <- "extdata/hg38.fa"

# text file containing sample names and fastq file paths
sampleFile <- "extdata/SRR_aligned_txt.txt"

# create alignments 
proj <- qAlign(sampleFile, genomeFile)

# quality check on alignment files
qQCReport(proj, pdfFilename = "qc_report.pdf")
alignmentStats(proj)