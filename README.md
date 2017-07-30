# Getting and Cleaning Data Assignment

## Contents
- run_analysis.R
  - Script which outputs a summary of the (UCI HAR Dataset)[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]
  - Steps:
    - Concatenate train and test data.
    - Add descriptive column names for factor variables.
    - Remove non standard deviation/mean measures
    - Output a tidy dataset which reports averages of each mean and standard deviation variable for each activity-subject pair.
- CodeBook.md
  - Codebook to accompany tidy-dataset.txt
- tidy-dataset.txt
  - Dataset which reports averages of each mean and standard deviation variable for each activity-subject pair.
