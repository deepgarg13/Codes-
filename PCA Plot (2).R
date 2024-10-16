#remove the 'width' column
countData <- as.matrix(subset(counts, select = c(-width)))

#define the experimental setup 
colData <- read.table(coldata_file, header = T, sep = '\t', 
                      stringsAsFactors = TRUE)

#define the design formula
designFormula <- "~ group"

library(DESeq2)
library(stats)

#create a DESeq dataset object from the count matrix and the colData 
dds <- DESeqDataSetFromMatrix(countData = countData, 
                              colData = colData, 
                              design = as.formula(designFormula))

#print dds object to see the contents
print(dds)

#For each gene, we count the total number of reads for that gene in all samples 
#and remove those that don't have at least 1 read. 
dds <- dds[ rowSums(DESeq2::counts(dds)) > 1, ]

dds <- DESeq(dds)

#compute the contrast for the 'group' variable where 'CTRL' 
#samples are used as the control group. 
DEresults = results(dds, contrast = c("group", 'CASE', 'CTRL'))

#sort results by increasing p-value
DEresults <- DEresults[order(DEresults$pvalue),]

#shows a summary of the results
print(DEresults)

library(DESeq2)

DESeq2::plotMA(object = dds, ylim = c(-5, 5))

library(ggplot2)

ggplot(data = as.data.frame(DEresults), aes(x = pvalue)) + 
  geom_histogram(bins = 100)

rld <- rlog(dds)

DESeq2::plotPCA(rld, ntop = 500, intgroup = 'group') + 
  ylim(-50, 50) + theme_bw()