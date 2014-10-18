## Course Project

# x_test/x_train are data set of the 561 feature vectors
# y_test/y_train are labels of the 6 feature activities
# sub_test/sub_train are volunteers ID for the activities recorded

## Read Test data set into R
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
sub_test <- read.table("./test/subject_test.txt")

## Read Training data set into R
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
sub_train <- read.table("./train/subject_train.txt")

## Merge the files into 3 data sets for now
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
colnames(subject_combine) <- "subject_id"
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

## Labels the data set with descriptive variable names
#sub("t","Time",names(combine_list))
#sub("f","Frequency",names(combine_list))
names(combine_list) <- gsub("Acc","Acceleration",names(combine_list))
names(combine_list) <- gsub("X","X-axial",names(combine_list))
names(combine_list) <- gsub("Y","Y-axial",names(combine_list))
names(combine_list) <- gsub("Z","Z-axial",names(combine_list))
names(combine_list) <- gsub("Mag","Magnitude",names(combine_list))
names(combine_list) <- gsub("Gyro","AngularVelocity",names(combine_list))
names(combine_list) <- gsub("std","StandardDeviation",names(combine_list))
