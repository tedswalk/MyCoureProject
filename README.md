MyCourseProject
===============

The is a repository for the course project of Getting and Cleaning Data course.

Below are my approach to cleaning and getting the final tidy data:
Step1: Read and merge the respective training and test data into 3 data sets.
       x_combine from x_train and x_test
       y_combine from y_train and y_test
       subject_combine from sub_train and sub_test

Step2: Assign feature name to each variable in x_combine data set.
Step3: Extract the mean and standard deviation of each measurement into a new data set x_new.
Step4: Assign variable names to subject_combine and y_combine data sets.
Step5: Merged all 3 data sets into one big data set called combined_list.
Step6: Assign descriptive activity names to the activities in the data set based on the activity_labels.txt
Step7: Assign descriptive names to each measurement variables.
Step8: Generate a tidy data with the average of each variable for each activity with aggregate().
Step9: Write the tidy data into a .txt file with write.table().

The output of the tidy data file called "my_tidy_data.txt".
The file consists a total of 68 variables, these are:
  1 "subject" variable to indicate the 30 volunteered subjects
  1 "activity" varaible to indicate the 6 different activities involved
  66 measurement variables

There is a total of 180 observations, each for the specific suject with a specific activity.

