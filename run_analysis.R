# read data
setwd("C:/Users/Administrator/Desktop/test/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

features<- read.table("./features.txt",header=FALSE)
activityLabel<- read.table("./activity_labels.txt",header=FALSE)
subject_train<-read.table("./train/subject_train.txt", header=FALSE)
subject_test<-read.table("./test/subject_test.txt", header=FALSE)
xTrain<- read.table("./train/X_train.txt", header=FALSE)
yTrain<- read.table("./train/y_train.txt", header=FALSE)
xTest<- read.table("./test/X_test.txt", header=FALSE)
yTest<- read.table("./test/y_test.txt", header=FALSE)

# 1. Merges the training and the test sets to create one data set.
dataSet <- rbind(xTrain,xTest)
activity <- rbind(yTrain,yTest)
subject<- rbind(subject_train, subject_test)
names(activity) <- "activity"
names(subject) <- "subject"

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# Create a vector of only mean and std, use the vector to subset.
MeanStdOnly <- grep("mean()|std()", features[, 2]) 
dataSet<- dataSet[,MeanStdOnly]


#3. #Uses descriptive activity names to name the activities in the data set
# combine subject, activity, and mean and std only data set to create final data set.
dataSet <- cbind(subject,activity, dataSet)
activity_group <- factor(dataSet$activity)
levels(activity_group) <- activityLabel[,2]
dataSet$activity <- activity_group

# 4. Appropriately labels the data set with descriptive activity names.
features2<- gsub("[()]", "",features[, 2])
features2<- gsub("Acc", "Acceleration", features2)
features2<- gsub("BodyBody", "Body",features2)
features2<- gsub("^t", "Time", features2)
features2<- gsub("^f", "Frequency", features2)
features2<- gsub("Freq", "Frequency", features2)
features2<- gsub("Mag", "Magnitude", features2)
names(dataSet) <- c("subject","activity",features2[MeanStdOnly])

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
library(dplyr)
dataSet_average<- dataSet %>% group_by(subject,activity) %>% summarise_all(list(mean=mean))
write.table(dataSet_average, "average.txt", row.name=FALSE)
