# TidyData
Coursera Cleaning Data: Final Course Project

## Purpose of Repository
This repository provides the files to satisfy the final Course project for the Coursera 'Getting and Cleanding Data' course. The files that satisfy the submission requirements are 'Run_Analysis.R' and 'SamsungTidyData_Grouped.txt' 

This project analyzed accelerometer and gyroscope data from Samsung phones provided in the 'Human Activity Recognition Using Smartphones Dataset'. The provided dataset groups all data by subject and activity (not distiguishing between records flagged as 'test' vs 'training'), subsets the data to only those componenets providing mean and standard deviation information, and then provides means for those values grouped by subjed and activity.  

## Files in this Repository
* Run_Analysis.R: Script to download and process the data
* SamsungTidyData.txt: data from 'SamsungTidyData.txt' grouped by Subject and Activity and summarized by mean
* Features_info.txt

## Run_Analysis.R Script discussion
The Run_Analysis.R Script loads the Samsung data and processes it to provide the tidy data sets. This script performs the following operations:
* Downloads and unzips data
* Pulls appropriate data into data frames.
* Combine and label the assorted data, subject and activity pieces for the test and train data
* Subset the data to include only the mean and standard deviation columns
* Group and summarize numerical items by Subject and Activity
* Export this tidy data set to a .txt file

A complete descripton of the process taken in the code is included as comments in the .R file

## Codebook 
Variables provided in the SamsungTidyData.txt field include:
* Subject: the unique ID for each subject, range from 1-30
* Activity: the ID associated with a given activity
* Activity.Description: english langauge description of the activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
* mean and standard deviation measurements of the time (columns begin with time.) and frequency domain measurments (columns begin with fft.). These column names are essentially the same as those in the original data with the exception of (a) cleaning up spaces and punctuation with the 'make.names' function in R, and (b) changing t --> time. (for time data) and f -> fft. (for frequency data) at the begining of each column.  For a further description of the data please see the features_info.txt file provided by the original researchers.

## Data Attribution 
The source for data used in this project: 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Detailed information on the underlying experiment and project data set is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones




