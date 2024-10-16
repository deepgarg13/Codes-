library(BiocManager)
library(DESeq2)
library(ggplot2)
library(tidyverse)

#input files
counts_data <- read.csv('countdata.csv', row.names = 1)
head(counts_data)
colData <- read.csv('metadata.csv', row.names = 1)
head(colData)

#calling data
all(colnames(counts_data) %in% rownames(colData))
all(colnames(counts_data) == rownames(colData))


# Creating DESeqDataSet object
dds <- DESeqDataSetFromMatrix(countData = counts_data,
                              colData = colData,
                              design = ~DEX)

dds
# pre-filtering removing row with low gene counts
b <- rowSums(counts(dds))>=8
dds <- dds[b,]
dds

#factor set up for comparing of test and control parameters
dds$DEX <- relevel(dds$DEX, ref = "Control")


# running the DESeq for a$dexamethasone
dds <- DESeq(dds)

# writing the results
result <- results(dds)
write.csv(as.data.frame(result),file = "DESeq2_results.csv")
result


#exploring our results getting summary of our results
summary(result)

#contrasts
resultsNames(dds)

#MA plot
plotMA(result)

# Read the CSV file
df <- read.csv("DESeq2_results.csv", row.names = 1)

# Add a column for categorizing genes as UP, DOWN, or NO differential expression
df$diffexpressed <- "NO"
df$diffexpressed[df$log2FoldChange > 0.5 & df$pvalue < 0.01] <- "UP"
df$diffexpressed[df$log2FoldChange < -0.5 & df$pvalue < 0.01] <- "DOWN"

# Create a label column for displaying gene names
df$delabel <- rownames(df)

# Volcano plot with color differentiation and labels
ggplot(data = df, aes(x = log2FoldChange, y = -log10(pvalue), color = diffexpressed, label = delabel)) +
  geom_point() +
  scale_color_manual(values = c("blue", "black", "red")) +  # Customize colors
  labs(x = "log2 Fold Change", y = "-log10 p-value", color = "Differential Expression") +
  theme_minimal() +
  theme(text = element_text(size = 20))