# CleningDataProject

Download the datasets provided for the homework.

Packages needed

library(dplyr)  - data operations
library(memisc) - creating a cookbook

Save the data in the working directory of R. The following are the steps that are executing in sequence to cleanup the data. This script will create a TidyDataset with name 'Tidydata.txt' and detail data 'Merged.txt'

1) Read the training and Test datasets to memory
2) Merge the data by subject, activity. Also merge the features
3) create column names for Subject and activity
4) Read the acvity file for feature names and create column names for features
5) Merge Subject and activity data
6) Create final dataset with subject, actviity and data
7) use dplyr to  subjset the table with only Mean and Std deviation data
8) #Get the labels from Activity_labels file and assign the labels
9) Rename the column names by the substring
10) #Use dplyr to get the summary by the variable
11) Save the tidy data to working directory
12) #create a cookbook
