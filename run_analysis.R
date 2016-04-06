### program run_analysis.R
### autor: Edgar Manukyan
### date: 04 April 2016

# Please place source text files from Samsung data into your working directory

### reading data in ###
library(data.table)

# reading features.txt for variable names
varNames <- fread("./features.txt")

# reading measurments data
dtrain <- fread("./X_train.txt")
names(dtrain) <- varNames$V2
dtest <- fread("./X_test.txt")
names(dtest) <- varNames$V2

# participants SubjectIDs
dtrainSubjectID <- fread("./subject_train.txt")
names(dtrainSubjectID) <- c("SubjectID")
dtestSubjectID <- fread("./subject_test.txt")
names(dtestSubjectID) <- c("SubjectID")

# reading activities to later merge with measurments
activTrain <- fread("./y_train.txt")
names(activTrain) <- c("ACT")
activTrain$rowID <- as.numeric(row.names(activTrain))
activTest <- fread("./y_test.txt")
names(activTest) <- c("ACT")
activTest$rowID <- as.numeric(row.names(activTest))

# reading activity labels
activLabels <- fread("./activity_labels.txt")
names(activLabels) <- c("ACT", "Activity")

library(dplyr)

activTrain <- merge(activTrain, activLabels, by = "ACT") 
activTrain <- arrange(activTrain, rowID)
activTest <- merge(activTest, activLabels, by = "ACT")
activTest <- arrange(activTest, rowID)

activTrain <- select(activTrain, Activity)
activTest <- select(activTest, Activity)

### end of rading data in ###

# since training and testing datasets are from different subjects we can't merge
# them side by side rather we can only stack them and both of them have the same
# number of variables in the same order.

# Merges the training and the test sets to create one data set.
# merge participan's ids and activities with measurments
# Uses descriptive activity names to name the activities in the data set 
# merging activity description
dtrain <- cbind(dtrainSubjectID, activTrain, dtrain)
dtest <- cbind(dtestSubjectID, activTest, dtest)

# stack test and train data together
data_combined0 <- rbind(dtrain, dtest)

# Extracts only the measurements on the mean and standard deviation for each
# measurement.

data_combined1 <- select(data_combined0,
                        SubjectID, Activity,
                        contains("mean"),
                        contains("std"),
                        -contains("meanFreq"))

# making tidy data
library(tidyr)
data_combined <- gather(data = data_combined1,
                         key = Measurment,
                         value = Value, 
                         -SubjectID,
                         -Activity)

data_combined <- arrange(data_combined, SubjectID, Activity)


# From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.

grouped_data_combined <- group_by(data_combined, SubjectID, Activity, Measurment)
summary_data <- summarise(grouped_data_combined, Average = mean(Value))

write.table(summary_data, row.names = FALSE, file = "./summary_data.txt")
