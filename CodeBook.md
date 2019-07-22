
# Code Book

## 1 Read data and Merge
subject_test : subject IDs for test
subject_train : subject IDs for train
xTest : values of variables in test
xTrain : values of variables in train
yTest : activity ID in test
yTrain : activity ID in train
activityLabel : Description of activity IDs in yTest and yTrain
features : description(label) of each variables in xTest and xTrain
dataSet : bind of xTrain and xTest


## 2. Extract only mean and std
Create a vector of only mean and std labels, then use the vector to subset dataSet.

MeanStdOnly : a vector of only mean and std labels extracted from 2nd column of features
dataSet : at the end of this step, dataSet will only contain mean and std variables


## 3. name the activities in the data set
Group the activity column of dataSet as "group_activity", then rename each levels with 2nd column of activity_levels. Finally apply the renamed "group" to dataSet's activity column.

    
## 4. Changing Column label of dataSet
Creat a clean names: features2 byt getting rid of "()", and replace a few characters, then combine "subject',"activity" and features2 c("subject","activity",features2[MeanStdOnly]), use this character vector to change the name of dataSet.


## 5. Output tidy data
DataSet is averaged thrhough the sorted dataset accordign to subject and activity. The tidy data is saved as "average.txt".
