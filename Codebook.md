## About the `analysis\_run.R` script:
Beside the five steps that is necessary to be included according to the assignment discription, this script downloads automatically the compressed data-files into a folder called `newfolder`, extrat the data in side of it, and then run the analysis.

## Variables:
Actually, The assignment description does not need to treat all files in the data set, but only:
- `activity_labels.txt` : contains the name of the activity and its coding number.
- `freatures.txt` : is a vector of all features in the experiment (i.e. the names of all measured values)
- `test/X_test.txt` : contains the value of each measured feature
- `test/y_test.txt` : contains the index-nummber of the activity
- `test/subject_test.txt` : contains the index-number of the subject who did the test
- `train/X_train.txt` : contains the value of each measured feature
- `train/y_train.txt` : contains the index-nummber of the activity
- `train/subject_train.txt` : contains the index-number of the subject who did the training

## Downstream of the steps:
+ download and extract the data set
+ merging the training and the testing data sets
+ reading the variable names
+ finding the wanted variables
+ the results vector is numeric, it returns the number of each variable that contain the words \"mean\" or "std" in its definition string
+ getting the corresponding names and convert them to all-lower-case
+ subsetting the x- and y- data sets
+ reading the activities
+ substituting the numbers with the corresponding activity
+ naming the column (all_y)
+ naming the participant column
+ merging all data sets into one
+ setting a descriptive variable names
+ creating the average data set for each activity of each participant
