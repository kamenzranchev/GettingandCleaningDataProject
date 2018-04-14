#############################################
# Getting and Cleaning Data Course Project  #
# Tidy Data from                            #
# Activity Recognition Using Data Set Files #
#############################################

# cleaning the enviroment and loading the librabies
rm(list = ls())
library(reshape2)

# downloading and extracting the data from the zip archive
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./data.zip" )
unzip(zipfile = "./data.zip" )

# reading labels and variable names from files into character vectors 
features <- (read.csv(file = "./UCI HAR Dataset/features.txt", sep = "", header = FALSE, stringsAsFactors = FALSE ))$V2
activity_labels <- (read.csv(file = "./UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE, stringsAsFactors = FALSE ))$V2

# reading test data into  vectors and a data frame
subject_test <- (read.csv( file = "./UCI HAR Dataset/test/subject_test.txt", header = FALSE))$V1
y_test <- (read.csv(file = "./UCI HAR Dataset/test/y_test.txt", header = FALSE ))$V1
X_test <- read.csv(file = "./UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)

# applying variable names to features
colnames(X_test) <- features

# putting the test data together and assigning activity_labels as factor levels
test_data <- cbind(subject = subject_test, activity = y_test, set = "test", X_test )
test_data$activity <- factor(test_data$activity, labels = activity_labels)

# reading train data into vectors and a data frame
subject_train <- (read.csv( file = "./UCI HAR Dataset/train/subject_train.txt", header = FALSE))$V1
y_train <- (read.csv(file = "./UCI HAR Dataset/train/y_train.txt", header = FALSE ))$V1
X_train <- read.csv(file = "./UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)

# applying variable names to features
colnames(X_train) <- features

# putting the train data together and assigning activity_labels as factor levels
train_data <- cbind(subject = subject_train, activity = y_train, set = "train", X_train )
train_data$activity <- factor(train_data$activity, labels = activity_labels)

# merging the train and the test data and selecting only average and standard deviantion measures into the final dataset
merged_data <- rbind(train_data, test_data)
final_data <- merged_data[, c(1:3, 
                              grep("mean", colnames(merged_data)), 
                              grep( "std", colnames(merged_data))
                              )]
# cleanning up
rm(list = ls()[!(ls() =="final_data" )])

# reshaping data to one record for each subject-activity combination
final_data$subject <- factor(final_data$subject)
aq <- melt(final_data[-3], id = c("subject", "activity"))
tidy_data_set <- dcast(aq, subject + activity ~ variable, value.var = "value", fun.aggregate = mean)

# writing the tidy data frame into a txt file
write.table(tidy_data_set, file = "./tidy_data_set.txt" , row.name = FALSE)
