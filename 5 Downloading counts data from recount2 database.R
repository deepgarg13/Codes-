## Install recount from Bioconductor
library(BiocManager)
BiocManager::install('recount')

## Browse the vignetets for a quick description of how to use the package
library('recount')
browseVignettes('recount')

#Get working directory
getwd()

#Set new working directory
setwd("WORKING_DIRECTORY_LOCATION")

## Download the RangedSummarizedExperiment object at the gene level for 
## study SRR_STUDY_ACCESSION_ID
url <- download_study('SRR_STUDY_ACCESSION_ID')

## View the url for the file by printing the object url
url

## Load the data
load(file.path('SRR_STUDY_ACCESSION_ID', 'rse_gene.Rdata'))

## Scale counts
rse <- scale_counts(rse_gene)
