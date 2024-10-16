#compute the variance of each gene across samples
V <- apply(tpm, 1, var)

#sort the results by variance in decreasing order 
#and select the top 100 genes 
selectedGenes <- names(V[order(V, decreasing = T)][1:100])

library(pheatmap)

pheatmap(tpm[selectedGenes,], scale = 'row', show_rownames = FALSE)

colData <- read.table(coldata_file, header = T, sep = '\t', 
                      stringsAsFactors = TRUE)
pheatmap(tpm[selectedGenes,], scale = 'row', 
         show_rownames = FALSE, 
         annotation_col = colData)