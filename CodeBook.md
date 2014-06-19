CodeBook for the Course Project for Coursera Getting and Cleaning Data Course
====================================================================================

Author: Razamut
===================================================================================
Script written using RStudio Version 0.98.501 on Mac OSX 10.9.3 with R version 3.1.0



Instructions for doing the project:
-----------------------------------
One of the most exciting areas in all of data science right now is wearable   
computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) .    
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced   
algorithms to attract new users. The data linked to from the course website represent   
data collected from the accelerometers from the Samsung Galaxy S smartphone. A full   
description is available at the site where the data was obtained:    

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following:   
1. Merges the training and the test sets to create one data set.    
2. Extracts only the measurements on the mean and standard deviation for each measurement.     
3. Uses descriptive activity names to name the activities in the data set.      
4. Appropriately labels the data set with descriptive variable names.     
5. Creates a second, independent tidy data set with the average of each variable for   
each activity and each subject.    

Code
============

This CodeBook explains how the data provided for the project was manipulated using   
the script int the file run_analysis.r  in order to obtain the desired results of   
the instructions. The data is the result of an experiment on 30 volunteers who wore  
Samsung Galaxy SII while permorming six activities.

For more information on the experiment please refer to the README.txt file contained   
in the data for the project.    

PART I
========================================

Upon downloading the data, we set the working directory to the dowloanded data folder
using the R function setwd("./downloaded_folder").

The first task is to merge files in the "train" and "test" folders.   
The following variables are used:   
* ftr1 : reads the file X_train.txt
* ftr2 : reads the file Y_train.txt
* ftr3 : reads the file subject_train.txt
* V562 : name assigned to ftr2 and ftst2 
* V563 : name assigned to ftr3 and ftst3
* traindata : binds ftr1,ftr2, and ftr3 columnwise
* ftst1 : reads the file X_test.txt
* ftst2 : reads the file Y_test.txt
* ftst3 : reads the file subject_test.txt
* testdata : binds ftst1, ftst2, and ftst3 columnwise
* my_data1 : binds traindata and testdata rowwise

my_data1 is the desired result for part I. 


PART II
=================================================

The task is to extract from my_data1 those columns 
that measure mean and standard deviation. To do that 
we first need to look into the data file features.txt
which contains the descriptive names of the first 561
columns of my_data1. In order to do that we do the following:

* labels_data : reads the file features.txt
* names_list : converts labels_data into a character 

Then you may visually inspect names_list using, for example, the R function 
View() to show the file before  picking out all columns that measure mean and std. 

* rel_cols : is the list of the relevant columns 
* my_data2 : is the subset of my_data1 that measure mean and std

my_data2 is therefore the desired result. 


PART III
=========================================================

In this portion of the project we are required to replace the numerical values of
column 562 in my_data1 with their corresponding descriptive labels. The file that 
contains the 6 descriptive names is activity_labels.txt.

We use the following variables:
* actvty_data : reads the activity_labels.txt file
* my_factor : takes a copy of column 562 and converts it to a factor

my_factor is then passed the descriptive names as its levels. This consequently turns  
my_factor into a factor of names as opposed to its initial numerical form. The
following variable is used next.
* my_list : my_factor converted to a list

Then my_data1[,562] <- my_list replaces column 562 in my_data1 with my_list, and 
the  result is the new table my_data1 containing descriptive names in column 562.


PART IV
=========================================

In this part we are going to replace the automatic variable names in my_data1 with
the appropriate descriptive names given in the project data file features.txt. So the
first step is to extend  names_list by 2  to include valid names for the last 2
columns of my_data1. 

"activity_label" and "subject_id" are appended to the names_list in that order. 
Then using names() we assign replace the names of the variables in my_data1 with 
the enhanced names_list. That concludes this part. 

PART V
============================================

In the last part of the project, we are to report a tidy data table with the average
of each variable for each activity and each subject.

To do that we do the following:
* We load the package plyr
* my_tidyData : variable that applies the function ddply to my_data1  in an 
  appropriate faction
* Write the my_tidyData to the file my_tidyData.txt.

The tidy data is now located in the home directory and we are done. 
















