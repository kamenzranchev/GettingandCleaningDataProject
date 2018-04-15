# Getting and Cleaning Data Course Project

 This repository contains my submission for the final programming assigment of the course.
 
 The files in it are as follows:
  1. R code *run_analysis.R* for gathering, merging, labeling and reshaping data from   
Human Activity Recognition Using Smartphones Data Set 
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)
in order to generate a tidy data set. 
 2. Code Book *Codebook.md* describing the resuling data set *tidy_data_set.txt*.
 
 The code at first downloads and extracts the file into the working folder.
 The data for features and actities labels are read and loaded as character vectors,
 y (activities) and subjects values - as numeric vectors and
 the X (measure) values - as data frames for both test and train data.
 
 Then measures/features names are assign as colnames 
 the subjects and activities variables are added to the X data frames (cbind), 
 activities labels are assigned as factor levels labels and
 both data frames are put one upon the other (rbind).
 
 Then only mean and std measures are extracted and data is melted and casted in a way 
 each activity of each subject to be in one row containing the average values for each features/measures.
 
 
 

