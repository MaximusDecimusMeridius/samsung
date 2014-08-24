run_analysis.R
=======

This function takes as input the Samsung data "UCI HAR Dataset" and outputs a tidy, reduced data set. For each observation of subject and activity, the new data set gives the average of the measured mean and standard deviation for each variable,  

The script reads in all data, labels and subjects. It then combines the test and training data in to a single data frame [OBJECTIVE 1]

It adds two columns to the merged data frame for subject id and avtivity label, and then extracts only the measurements on the mean and standard deviation for each measurement [OBJECTIVE 2]. 

Note: Per the features_info.txt, the  the columns that give this value for each signal are

tBodyAcc-XYZ 
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag


We then substitute activity 1-6 to readable label according to activity_labels.txt [OBJECTIVE 3]

We then replace variables with readable names according to features_info.txt [OBJECTIVE 4]

Finally, we aggregate each variable over subject and activity, and print the resulting data frame to tidy_data.txt. [OBJECTIVE 5] I opted for the wide version of the data (as opposed creating a narrow set with the plyr package) because I find it easier to read.






