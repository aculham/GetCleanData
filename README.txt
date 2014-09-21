The code provided here performs analysis on the UCI HAR Dataset.

Included files: 
	run_analysis.R	-  Performs the required analysis
	final_data.R	-  A table of the tidy data created in run_analysis.R

Requirements:
	1. The script requires that the data located here be downloaded and unzipped:
		https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	2. The directory structure in the zip files is needed for the code to work correctly
	3. The code requires several R packages be installed, including reshape2 and its dependencies.

To execute the script:
	1. Set working directory to the UCI HAR Dataset.  For example, setwd( "C:\\UCI HAR Dataset" ).
	2. Execute run_analysis.R
	3. The variable final_data contains the tidy dataset

To load the tidy data execute read.table( final_data.txt, header=TRUE)