library(stats)
library(ggplot2)

#transpose the matrix 
M <- t(tpm[selectedGenes,])

# transform the counts to log2 scale 
M <- log2(M + 1)

#compute PCA 
pcaResults <- prcomp(M)

# pcaResults contains your PCA results
# and colData contains metadata including the 'group' variable

# Convert pcaResults to a data frame
pca_df <- as.data.frame(pcaResults$x)

# Combine pca_df with colData
combined_data <- cbind(pca_df, colData)

# Create the ggplot visualization
ggplot(combined_data, aes(x = PC1, y = PC2, color = group)) +
  geom_point() +
  labs(title = "PCA Visualization", x = "PC1", y = "PC2")

summary(pcaResults)