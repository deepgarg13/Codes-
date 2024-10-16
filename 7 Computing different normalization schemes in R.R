# create data sets for computation
counts_file <- system.file("extdata/rna-seq/SRR_ID.raw_counts.tsv", package = "compGenomRData")
coldata_file <- system.file("extdata/rna-seq/SRR_ID.colData.tsv", package = "compGenomRData")

counts <- as.matrix(read.table(counts_file, header = T, sep = '\t'))

summary(counts[,1:3])

cpm <- apply(subset(counts, select = c(-width)), 2, function(x) x/sum(as.numeric(x)) * 10^6)

colSums(cpm)

# create a vector of gene lengths 
geneLengths <- as.vector(subset(counts, select = c(width)))

# compute rpkm 
rpkm <- apply(X = subset(counts, select = c(-width)), MARGIN = 2, FUN = function(x) { 10^9 * x / geneLengths / sum(as.numeric(x)) })

colSums(rpkm)

#find gene length normalized values 
rpk <- apply( subset(counts, select = c(-width)), 2, function(x) x/(geneLengths/1000))

#normalize by the sample size using rpk values
tpm <- apply(rpk, 2, function(x) x / sum(as.numeric(x)) * 10^6)

colSums(tpm)