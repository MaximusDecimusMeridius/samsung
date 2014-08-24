



## Combine all test data in to one data frame
test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep= "", stringsAsFactors = FALSE)
test_labels <- read.table("./UCI HAR Dataset/test/y_test.txt", sep= "", stringsAsFactors = FALSE)
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep= "", stringsAsFactors = FALSE)

## Combine all training data in to one data frame
train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep= "", stringsAsFactors = FALSE)
train_labels <- read.table("./UCI HAR Dataset/train/y_train.txt", sep= "", stringsAsFactors = FALSE)
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep= "", stringsAsFactors = FALSE)



#####################
### [Objective 1] ###
#####################

## Merge the training and the test sets to create one data set
testandtrain <- rbind(test, train)




## Create two data frames with columns for labels and subjects for test and train data, respectively 
test_subj_activity <- cbind(test_subject, test_labels)
train_subj_activity <- cbind(train_subject, train_labels)

## Now combine in to on df containing all subject and activity rows
all_subj_activity <- rbind (test_subj_activity, train_subj_activity)

## Now add these columns to the merged data set
alldata <- cbind(all_subj_activity, testandtrain)

## Create vector of features
f <- read.table("./UCI HAR Dataset/features.txt", sep= "", stringsAsFactors = FALSE)
features <- f[,2]

## Create name vector and assign to main data frame
newnames <- c( c("subject", "activity"), features)
names(alldata) <- newnames




#####################
### [Objective 2] ###
#####################

## Get only columns with name mean() and std()
meanstd <- sapply(features, function(x) grepl("std|mean\\(\\)" ,x) )
selected_names <- c(c("subject", "activity"),features[meanstd])
selecteddata <- alldata[, selected_names]

## Order data based on subject, activity
ordereddata <- selecteddata[order(selecteddata$subject, selecteddata$activity),]

#####################
### [Objective 3] ###
#####################

## Substitute activity 1-6 for readable names
activity <- ordereddata$activity
activities <- c("walking", "walking upstaris", "walking downstairs", "sitting", "standing", "laying")

for (i in 1:6){
        activity <- gsub(i, activities[i], activity)
}
ordereddata$activity <- activity



#####################
### [Objective 4] ###
#####################

## Replace variables with readable names

variables <- names(ordereddata)

old_names <- c("tBodyAcc-",
                "tGravityAcc-",
                "tBodyAccJerk-",
                "tBodyGyro-",
                "tBodyGyroJerk-",
                "tBodyAccMag-",
                "tGravityAccMag-",
                "tBodyAccJerkMag-",
                "tBodyGyroMag-",
                "tBodyGyroJerkMag-",
                "fBodyAcc-",
                "fBodyAccJerk-",
                "fBodyGyro-",
                "fBodyAccMag-",
                "fBodyBodyAccJerkMag-",
                "fBodyBodyGyroMag-",
                "fBodyBodyGyroJerkMag-",
               "mean\\(\\)",
               "std\\(\\)",
               "-X",
               "-Y",
               "-Z")

new_names <- c("body accelerometer ",
               "gravity accelerometer ",
               "body accelerometer jerk ",
               "body gyroscope ",
               "body gyroscope jerk ",
               "body accelerometer magnitude ",
               "gravity accelerometer magnitude ",
               "body accelerometer jerk magnitude ",
               "body gyroscope magnitude ",
               "body gyroscope jerk magnitude ",
               "fft body accelerometer ",
               "fft body accelerometer jerk ",
               "fft body gyroscope ",
               "fft body accelerometer magnitude ",
               "fft body accelerometer jerk magnitude ",
               "fft body gyroscope magnitude ",
               "fft body gyroscope jerk magnitude ",
               "mean",
               "standard deviation",
               " x-axis",
               " y-axis",
               " z-axis")

for (i in 1:length(old_names)){
        variables <- gsub(old_names[i], new_names[i], variables)
}

names(ordereddata) <- variables



#####################
### [Objective 5] ###
#####################

## Aggregate each variable over subject and activity

avgout <- aggregate(ordereddata[,3:ncol(ordereddata)],by =list(ordereddata$subject, ordereddata$activity), FUN = mean)

colnames(avgout)[1:2] <- c("subject", "activity")


## Write to text file
write.table(avgout, file = "./tidy_data.txt", row.names = FALSE)


