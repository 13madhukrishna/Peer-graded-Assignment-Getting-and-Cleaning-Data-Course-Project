



#downloading the raw data set:

dataset <- "Week 3 assignment.zip"

if (!file.exists(dataset)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, dataset, method="curl")
}  


#extracting the files in the .zip file:

unzip(dataset)

#listing the files in the working directory to confirm the newly extracted files:

list.files()


#loading the package for editing the data frames
library(dplyr)


#storing the data so that individual data frames can be used easily

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")


subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))


x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)

# 1. Merging the training and the test sets to create one data set:

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merge_test <- cbind(Subject, Y, X)

# 2. Extracting only the measurements on the mean and standard deviation for 
#     each measurement.


Mean_SD_extract <- Merge_test %>% select(subject, code, contains("mean"), contains("std"))

# 3. Descriptive activity names to name the activities in the data set


names(Mean_SD_extract)[2] = "activity"

# 4. Appropriately labeling the data set with descriptive variable names:


names(Mean_SD_extract)<-gsub("Acc", "Accelerometer", names(Mean_SD_extract))
names(Mean_SD_extract)<-gsub("Gyro", "Gyroscope", names(Mean_SD_extract))
names(Mean_SD_extract)<-gsub("BodyBody", "Body", names(Mean_SD_extract))
names(Mean_SD_extract)<-gsub("Mag", "Magnitude", names(Mean_SD_extract))
names(Mean_SD_extract)<-gsub("^t", "Time", names(Mean_SD_extract))
names(Mean_SD_extract)<-gsub("^f", "Frequency", names(Mean_SD_extract))
names(Mean_SD_extract)<-gsub("tBody", "TimeBody", names(Mean_SD_extract))
names(Mean_SD_extract)<-gsub("-mean()", "Mean", names(Mean_SD_extract), ignore.case = TRUE)
names(Mean_SD_extract)<-gsub("-std()", "STD", names(Mean_SD_extract), ignore.case = TRUE)
names(Mean_SD_extract)<-gsub("-freq()", "Frequency", names(Mean_SD_extract), ignore.case = TRUE)
names(Mean_SD_extract)<-gsub("angle", "Angle", names(Mean_SD_extract))
names(Mean_SD_extract)<-gsub("gravity", "Gravity", names(Mean_SD_extract))


# 5. Based on the last data set, creating another independent data set with 
#     the average of each variable for each activity and each subject.


FinalData <- Mean_SD_extract %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)









