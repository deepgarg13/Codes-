library(EDASeq)

par(mfrow = c(1, 2))

plotRLE(countData, outline=FALSE, ylim=c(-4, 4), 
        col=as.numeric(colData$group), 
        main = 'Raw Counts')

plotRLE(DESeq2::counts(dds, normalized = TRUE), 
        outline=FALSE, ylim=c(-4, 4), 
        col = as.numeric(colData$group), 
        main = 'Normalized Counts')