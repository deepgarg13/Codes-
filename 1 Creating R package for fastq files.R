#Install R package "devtools" to create desired package.
install.packages("devtools")

#Load "devtools" & "ShortRead" package to build and interpret the .fastq.gz files.
library(devtools)
library(ShortRead)

#Get the current working directory.
getwd()

#Set the working directory for the new package containing the .fastq.gz files.
setwd("SET_WORKING_DIRECTORY_LOCATION")

#Get the new working directory.
getwd()

#Create the package "PACKAGE_NAME" and a new package directory to store the .fastq.gz files.
create("PACKAGE_NAME")
dir.create("PACKAGE_NAME/inst")
dir.create("PACKAGE_NAME/inst/extdata")

#Copy the .fastq.gz, .fa, and other essential files from the existing location and import them into the package data directory.
file.copy("FASTQ_FILE_NAME", "PACKAGE_NAME/inst/extdata/FASTQ_FILE_NAME")
file.copy("hg38.fa", "PACKAGE_NAME/inst/extdata/hg38.fa") #hg38.fa is human genome fasta file, user need to download the file from UCSC Genome Browser.

#Build and Install the new created R package.
build("PACKAGE_NAME")
install("PACKAGE_NAME")