# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project submitted by Edgar Manukyan

This analysis uses data from "Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine" by Davide Anguita et al. [1]. It combines data from training and test data, extracts only mean and standard deviation measurements. Also average values of each measurement were calculated for each activity and each subject. Unit of measurement is Hz.
The following steps were involved during the analysis and are programmed in R script run_analysis.R:

0. download original data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

1. read original features.txt to obtain Measurement names;
2. read original X_train.txt and X_test.txt to obtain numerical values of all Measurements in training and testing sets;
3. measurement names from step 1 were used to name all measurements in step 2.
4. read original subject_train.txt and subject_test.txt to obtain subject identification numbers for each row in training (X_train.txt) and testing (X_test.txt) sets. Rows correspond to rows in data from step 2.
5. read original y_train.txt and y_test.txt to obtain activity codes (integers from 1 to 6) that correspond to each row in data from step 2.
6. read original activity_labels.txt to obtain clear labels along with codes for each activity that study subjects were involved in; these labels were merged with data in step 4 by activity codes.
7. Subject identification numbers (from step 3), activity labels (from step 5) were merged to measurement values from step 2 side by side without altering the sorting order in original dataset.
8. Only the following columns were left in dataset: patient identification number, activity labels and Measurements from containing mean and std names.
9. final data_combined was sorted by Subject identification numbers and Activity
10. Average values of each measurements were calculated for each activity and each subject and resulting dataset was saved as summary_data.
 
 [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
