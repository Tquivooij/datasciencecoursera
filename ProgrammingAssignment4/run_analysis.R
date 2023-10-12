###################################
## Programming assignment Getting and Cleaning Data
## run_analysis.R  
## Tim Quivooij
## 11-10-2023
## Steps of the assignment:
## 1. merge the training and test sets to create one data set
## 2. extracts only the measures on the mean and SD for each measurement
## 3. uses descriptive activity names to name the activities in the dataset
## 4. approproately labels the 
## 5. create a second independent dataset wit the average of each variable for
## each activity and subject
####################################

## package dplyr is required
library(dplyr)

# set the working directory to programming assignment 4
setwd("./ProgrammingAssignment4")
# getwd()

# Download dataset
filename <- "Coursera_DS3_Final.zip"

# Checking if archive already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists and unzip the files
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Assigning all data frames
# features: List of all features.
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
# activities: Links the class labels with their activity name.
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
# subject_test: Each row identifies the subject who performed the activity for each window sample.
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
# x_test: Test set.
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
# y_test: Test labels.
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
# subject train: Each row identifies the subject who performed the activity for each window sample.
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
# x_train: Training set.
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
# y_train: Training labels.
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


# Step 1: Merges the training and the test sets to create one data set.
totalX <- rbind(x_train, x_test) # merge test set and train set
totalY <- rbind(y_train, y_test) # merge test labels and training labels
Subject <- rbind(subject_train, subject_test) # merge the test and training subjects
MergedData <- cbind(Subject, totalY, totalX) # merge 
MergedData

# Step 2: Extract only the measurements on the mean and standard deviation for each measurement.
TidyData <- MergedData %>% select(subject, code, contains("mean"), contains("std"))

# Step 3: Uses descriptive activity names to rename the activities in the data set.
TidyData$code <- activities[TidyData$code, 2]

# Step 4: Appropriately labels the data set with descriptive variable names.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# Step 5: From the data set in step 4, creates a second,
# independent tidy data set with the average of each variable for each activity
# and each subject.
SecondTidyData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(SecondTidyData, "TidyData.txt", row.name=FALSE)

# Checking variable names
str(SecondTidyData)










