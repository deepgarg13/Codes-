#Load the R package containing the .fastq.gz files.
library(PACKAGE_NAME)

#Load the pre-requisite packages to read and form plots with the .fastq.gz files
library(Rqc)
library(ShortRead)

#Create an object "folder" containg the path access to the .fastq.gz files. Check whether the files have been exported with "dir()" command.
folder = system.file(package="PACKAGE_NAME", "extdata")
dir(folder)

#Create an object "qcRes" which allows the package rqc to perform quality check on the .fastq.gz files.
qcRes=rqc(path = folder, pattern = ".fastq.gz", openBrowser=FALSE)

#Commands performed to check the quality of the .fastq.gz reads in the object "qcRes".
rqcCycleQualityBoxPlot(qcRes)
rqcCycleBaseCallsLinePlot(qcRes)
rqcReadFrequencyPlot(qcRes)
