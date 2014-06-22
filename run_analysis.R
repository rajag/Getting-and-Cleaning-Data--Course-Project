## You should create one R script called run_analysis.R that does the following. 
## 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
## 
## Good luck!

## 1. Merges the training and the test sets to create one data set.
# load training
setwd("C:\\LEARN\\DataScience_JH")
X_train <- read.table('UCI HAR Dataset\\train\\X_train.txt')
y_train <- read.table('UCI HAR Dataset\\train\\y_train.txt')

# load test
X_test <- read.table('UCI HAR Dataset\\test\\X_test.txt')
y_test <- read.table('UCI HAR Dataset\\test\\y_test.txt')

# append
X_merged <- rbind(X_train, X_test)
y_merged <- rbind(y_train, y_test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# load features
features <- read.table('UCI HAR Dataset\\features.txt')
# find 'mean' and 'std' feature names
extract_mean_std <- X_merged[,sort(c(grep('mean', features[,2]), grep('std', features[,2])))]
names(extract_mean_std) <- features[sort(c(grep('mean', features[,2]), grep('std', features[,2]))),2]

## 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table('UCI HAR Dataset\\activity_labels.txt')
for (i in 1:6 ) {
  y_merged[y_merged[,1] == i,2] <- activity_labels[i,2]
}
names(y_merged) <- c('LabelID', 'ActivityLabel')

## 4. Appropriately labels the data set with descriptive activity names. 
tidydata <- cbind(y_merged, extract_mean_std)
#write.csv(tidydata, "tidydata01.csv")
write.table(tidydata, "tidydata01.txt")
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subject_train <- read.table('UCI HAR Dataset\\train\\subject_train.txt')
subject_test <- read.table('UCI HAR Dataset\\test\\subject_test.txt')

tidydata2 <- NULL
subj_uni <- unique(subject_train)
for (i in 1:dim(subj_uni)[1]) {
  for (j in 1:dim(activity_labels)[1]) {
    tmp <- colMeans(X_train[subject_train == subj_uni[i,1] & y_train == j,])
    tmp2 <- c(subj_uni[i,1], j)
    if (i==1 & j==1) { # set names to data.frame only once
      names(tmp) <- features[,2]
      names(tmp2) <- c("Subject", "Activity")
    }
    tidydata2 <- rbind(tidydata2, c(tmp2, tmp))
    rm(tmp)
  }
}
subj_uni <- unique(subject_test)
for (i in 1:dim(subj_uni)[1]) {
  for (j in 1:dim(activity_labels)[1]) {
    tmp <- colMeans(X_test[subject_test == subj_uni[i,1] & y_test == j,])
    tidydata2 <- rbind(tidydata2, c(subj_uni[i,1], j, tmp))
    rm(tmp)
  }
}

#write.csv(tidydata2, "tidydata02.csv")

write.table(tidydata2, "tidydata02.txt")
