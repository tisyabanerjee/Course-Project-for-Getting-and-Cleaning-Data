library(dplyr)
#Reading all data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names = "code")
# 1 Merging test and training datasets
X <- rbind(x_test, x_train)
Y <- rbind(y_test, y_train)
SUBJECT <- rbind(subject_test, subject_train)
Mergedtable <- cbind(SUBJECT, X, Y)
# 2 Extracts only the measurements on the mean and standard deviation for each measurement
TidyData <- Mergedtable %>% select(subject, code, contains("mean"), contains("std"))
# 3 Uses descriptive activity names to name the activities in the data set. 
TidyData$code <- activities[TidyData$code, 2]
# 4 Appropriately labels the data set with descriptive variable names
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
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
IndependentData <- TidyData %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(IndependentData, "IndependentData.txt", row.name = FALSE)