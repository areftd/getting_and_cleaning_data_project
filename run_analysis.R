library(plyr)
zipfile_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("./newfolder"))(dir.create("./newfolder"))
download.file(zipfile_url, destfile="./newFolder/compressedData.zip", method="curl")
unzip(zipfile="newfolder/compressedData.zip", exdir="./newfolder")

setwd("./newFolder/UCI HAR Dataset")

# merging the training and the testing data sets
xtest <- read.table("test/X_test.txt")
ytest_activity <- read.table("test/y_test.txt")
testing_participant <- read.table("test/subject_test.txt")

xtraining <- read.table("train/X_train.txt")
ytraining_activity <- read.table("train/y_train.txt")
training_participant <- read.table("train/subject_train.txt")

all_x <- rbind(xtraining, xtest)
all_y <- rbind(ytraining_activity, ytest_activity)
all_participant <- rbind(training_participant, testing_participant)

# reading the variable names
features <- read.table("features.txt")

# finding the wanted variables
# the results vector is numeric, it returns the number of each variable that contain the words "mean" or "std" in its definition string
mean_and_std_measurments <- grep("-(mean|std)\\(\\)", features[, 2])
# getting the corresponding names and convert them to all-lower-case
var_names <- tolower(features[mean_and_std_measurments,2])

# subsetting the x- and y- data sets
sub_all_x <- all_x[,mean_and_std_measurments]  
names(sub_all_x) <- var_names

# reading the activities
activ <- read.table("activity_labels.txt")

# substituting the numbers with the corresponding activity
all_y[,1] <- activ[all_y[,1],2]

# naming the column (all_y)
names(all_y) <- "activity"

# naming the participant column
names(all_participant) <- "participants"

# merging all data sets into one
complete <- cbind(sub_all_x, all_y, all_participant)

# setting a descriptive variable names
names(complete)<-gsub("^t", "time", names(complete))
names(complete)<-gsub("^f", "frequency", names(complete))
names(complete)<-gsub("acc", "Accelerometer", names(complete))
names(complete)<-gsub("gyro", "Gyroscope", names(complete))
names(complete)<-gsub("mag", "Magnitude", names(complete))
names(complete)<-gsub("bodybody", "Body", names(complete))

# creating the average data set for each activity of each participant
aver_data <- ddply(complete,.(participants,activity), function(x) colMeans(x[,1:66]))
write.table(aver_data,"aver_data.txt", row.name=FALSE)
