##Course Project for Cleaning Data Course
#This script looks at Samsung accelerometer data tackles the following tasks:
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.

##load libraries
library(dplyr)

##Url Location of Data and destination files on local system
zipurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destzip <- "./data/accelerometerdata.zip"
destfile <- "./data/accelerometer"

##download data to local
if(!file.exists("data")){dir.create("data")}
download.file(url=zipurl, destfile=destzip, method='curl')
unzip(destzip,exdir=destfile)

##Navigate Data folders to set wd as folder that is parent of test and train data 
setwd("data/accelerometer/UCI HAR Dataset")

##Local file locations
ftestx <- "./test/X_test.txt"
ftesty <- "./test/y_test.txt"
ftestsubject <- "./test/subject_test.txt"
ftrainx <- "./train/X_train.txt"
ftrainy <- "./train/y_train.txt"
ftrainsubject <- "./train/subject_train.txt"
ffeatures <- "./features.txt"
factivity <- "./activity_labels.txt"


##Read Data into R, use read.table settings to properly handle whitespaces in data set
#data tables
testx <- read.table(file=ftestx, sep="", header = FALSE, na.strings = "", stringsAsFactors = FALSE)
testy <- read.table(file=ftesty, sep="", header = FALSE, na.strings = "", stringsAsFactors = FALSE)
trainx <- read.table(file=ftrainx, sep="", header = FALSE, na.strings = "", stringsAsFactors = FALSE)
trainy <- read.table(file=ftrainy, sep="", header = FALSE, na.strings = "", stringsAsFactors = FALSE)
#subject data files
testsubject <- read.table(file=ftestsubject, sep="", header = FALSE, na.strings = "", stringsAsFactors = FALSE)
trainsubject <- read.table(file=ftrainsubject, sep="", header = FALSE, na.strings = "", stringsAsFactors = FALSE)
#reference tables: features = data labels, activity = activiy type 
features <- read.table(file=ffeatures, sep="", header = FALSE, na.strings = "", stringsAsFactors = FALSE)
activity <- read.table(file=factivity, sep="", header = FALSE, na.strings = "", stringsAsFactors = FALSE)

##Convert data files into one data frame with appropriate labels and headers
#Read factor vector for headers and labels into R and add as column headers. convert toproper r name format with make.names
fnames <- features[[2]]
colnames(testx) = make.names(fnames)
colnames(trainx) = make.names(fnames)
#add 'type' column to flag if test or training data
testx$Type <- "test"
trainx$Type <- "train"
#add header to label and subject data frames
colnames(testy) = "Activity"
colnames(trainy) = "Activity"
colnames(testsubject) ="Subject"
colnames(trainsubject) ="Subject"
#Add activity and subject columns to data frames
ctest <- cbind(testsubject,testy,testx)
ctrain <- cbind(trainsubject,trainy,trainx)
#Merge test and train data together into one data frame
all_data <- rbind(ctest,ctrain)

##Subset the data frame to select only the columns of interest, specifcally mean and standard deviation (std) columns
ad_ref <- all_data[, c(1:2, 564)]
ad_mean <- all_data[ , grepl("mean()", names(all_data)) ]
ad_std <- all_data[ , grepl("std()", names(all_data)) ]
subsetData <- cbind(ad_ref,ad_mean,ad_std)
#convert to tbl_df
sd <- tbl_df(subsetData)
#modify column names for readability
names(sd) <- gsub("^f","fft.",names(sd))
names(sd) <- gsub("^t","time.",names(sd))

##Join with reference table information to provide descriptive activity and  information
#modify activity colnames
colnames(activity) <- c("Activity","Activity.Description")
activity_df <- tbl_df(activity)
#merge on Activity
cleanData <- merge(activity_df,sd,by="Activity")
#Convert to tbl_df to use dplyr
cleanData <- tbl_df(cleanData)   

##Group and summarize numerical items by Subject and Activity
#ignore test vs. train data for this purpose
sumClean  <- cleanData %>%
      select(-type) %>%
      group_by (Subject,Activity,Activity.Description)%>%
      summarise_all(funs(mean))


