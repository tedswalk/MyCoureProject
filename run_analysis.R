## Course Project

# x_test/x_train are data set of the 561 feature vectors
# y_test/y_train are labels of the 6 feature activities
# sub_test/sub_train are the 30 volunteers for the activities recorded

## Read Test data set into R
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
sub_test <- read.table("./test/subject_test.txt")

## Read Training data set into R
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
sub_train <- read.table("./train/subject_train.txt")

## Merge the files into 3 data sets
y_combine <- rbind(y_train,y_test)
x_combine <- rbind(x_train,x_test)
subject_combine <- rbind(sub_train,sub_test)

## Read feature data set into R
features <- read.table("features.txt")

## Assign feature name to each variable in x_combine data set
colnames(x_combine) <- features$V2

## Extract the mean and standard deviation of each measurement into a new data set
meanlist <- grep("mean()",features$V2)
meanFreq <- grep("meanFreq",features$V2)
stdlist <- grep("std()",features$V2)
newlist <- sort(c(meanlist,stdlist))
## remove the meanFreq item from newlist
newlist2 <- newlist[!newlist %in% meanFreq] 
x_new <- x_combine[,newlist2]

## Assign variable names to subject_combine and y_combine data set
colnames(subject_combine) <- "subject"
colnames(y_combine) <- "activity"

## Merge all data into one big data set
combine_list <- cbind(subject_combine,y_combine,x_new)

## Read activity Labels
activitylabel <- read.table("activity_labels.txt")

## Name activities in the data set with descriptive activity names
for (i in 1:10299){
  if (combine_list$activity[i]==1){
    combine_list$activity[i] <- as.character(activitylabel$V2[1])
  }
  if (combine_list$activity[i]==2){
    combine_list$activity[i] <- as.character(activitylabel$V2[2])
  }
  if (combine_list$activity[i]==3){
    combine_list$activity[i] <- as.character(activitylabel$V2[3])
  }
  if (combine_list$activity[i]==4){
    combine_list$activity[i] <- as.character(activitylabel$V2[4])
  }
  if (combine_list$activity[i]==5){
    combine_list$activity[i] <- as.character(activitylabel$V2[5])
  }
  if (combine_list$activity[i]==6){
    combine_list$activity[i] <- as.character(activitylabel$V2[6])
  }
}

# change all to lower case and assign descriptive names to each variable
names(combine_list) <- tolower(names(combine_list))
names(combine_list) <- gsub("-"," ",names(combine_list))
names(combine_list) <- sub("mean..","mean",names(combine_list))
names(combine_list) <- sub("std..","standard deviation",names(combine_list))
names(combine_list) <- sub("tbodyaccjerkmag","time body acceleration jerk magnification",names(combine_list))
names(combine_list) <- sub("tbodyaccjerk","time body acceleration jerk",names(combine_list))
names(combine_list) <- sub("tbodygyrojerkmag","time body gyroscope jerk magnification",names(combine_list))
names(combine_list) <- sub("tbodygyrojerk","time body gyroscope jerk",names(combine_list))
names(combine_list) <- sub("tgravityaccmag","time gravity acceleration magnification",names(combine_list))
names(combine_list) <- sub("tbodyaccmag","time body acceleration magnification",names(combine_list))
names(combine_list) <- sub("tbodyacc","time body acceleration",names(combine_list))
names(combine_list) <- sub("tgravityacc","time gravity acceleration",names(combine_list))
names(combine_list) <- sub("tbodygyromag","time body gyroscope magnification",names(combine_list))
names(combine_list) <- sub("tbodygyro","time body gyroscope",names(combine_list))
names(combine_list) <- sub("fbodyaccjerk","frequency body acceleration jerk",names(combine_list))
names(combine_list) <- sub("fbodygyrojerk","frequency body gyroscope jerk",names(combine_list))
names(combine_list) <- sub("fbodyaccmag","frequency body acceleration mag",names(combine_list))
names(combine_list) <- sub("fbodyacc","frequency body acceleration",names(combine_list))
names(combine_list) <- sub("fbodybodygyrojerkmag","frequency body body gyroscope jerk magnification",names(combine_list))
names(combine_list) <- sub("fbodybodyaccjerkmag","frequency body body acceleration jerk magnification",names(combine_list))
names(combine_list) <- sub("fbodygyro","frequency body gyroscope",names(combine_list))
names(combine_list) <- sub("fbodybodygyromag","frequency body body gyroscope magnfication",names(combine_list))

## generate a tidy data with the average of each variable for each activity and each subject
finalfile <- aggregate(.~ subject + activity,data=combine_list,mean)

## write tidy data into a txt file format
write.table(finalfile, file="my_tidy_data.txt",row.name=FALSE)
