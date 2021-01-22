---
title: "CodeBook"
author: "Madhukrishna K U"
date: "23/01/2021"
output: html_document
---


## The run_analysis.R codes will help us download the collection of data sets and helps us 
## convert into a tidy data set.

The main steps of the run_analysis is as follows:
  
    
  1. Download the .zip file containing the data sets into the working directory and extract in into a folder.
  


  2. The data sets are stored into new variables 
  
      a. subject_test.txt will be stored into subject_test
      b. y_test.txt >> y_test
      c. subject_train.txt >> subject_train
      d. y_train.txt >> y_train
      e. activity_labels.txt >> activity_labels
      f. features.txt >> features
      g. X_test.txt >> X_test
      h. X_train.txt >> X_train
  
  
  3. Next, the code will merge the training and test data sets of x and y using rbind(), 
     them merged into a bigger data set with both x and y data.
     
      X <- rbind(x_train, x_test) 
      Y <- rbind(y_train, y_test)
      Subject <- rbind(subject_train, subject_test)
      Merge_test <- cbind(Subject, Y, X)
      
  4. Extracting only the measurements on the mean and standard deviation for each measurement.
      
      Mean_SD_extract data set is created subsetting the larger data set, "Merge_test"
      to return the standard deviation and mean.
  
  5. Appropriately labeling the data set with descriptive variable names 
    
      The column names in the data set is renamed to an appropriate title.
      
  6. Based on the last data set, creating another independent data set with the average of each variable for each activity and each subject.
      
      The created FinalData data table is then exported as a new  "FinalData.txt" file that will be now present in the working directory.
  
 
