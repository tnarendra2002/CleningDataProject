
# Assumption: Dataset is downloaded into the working directory

# Get the working directory

filepath <- getwd()

# Read the training and Test datasets to memory

trainingactivitydata <- read.table(file.path(filepath,"UCI_HAR_Dataset","train","y_train.txt"),header = FALSE)
testingactivitydata <- read.table(file.path(filepath,"UCI_HAR_Dataset","test","y_test.txt"),header = FALSE)
testingsubjectdata <- read.table(file.path(filepath,"UCI_HAR_Dataset","test","subject_test.txt"),header = FALSE)
trainingsubjectdata <- read.table(file.path(filepath,"UCI_HAR_Dataset","train","subject_train.txt"),header = FALSE)
trainingfeaturedata <- read.table(file.path(filepath,"UCI_HAR_Dataset","train","X_train.txt"),header = FALSE)
testfeaturedata <- read.table(file.path(filepath,"UCI_HAR_Dataset","test","X_test.txt"),header = FALSE)

# Merge the data by subject, activity. Also merge the features

subject <- rbind(trainingsubjectdata, testingsubjectdata)
activity <- rbind(trainingactivitydata, testingactivitydata)
features <- rbind(trainingfeaturedata,testfeaturedata)

# create column names for Subject and activity
names(subject) <- c("subject")
names(activity) <- c("activity")

# Read the acvity file for feature names and create column names for features
FeaturesNames <- read.table(file.path(filepath, "UCI_HAR_Dataset","features.txt"),head=FALSE)
names(features) <- FeaturesNames$V2

# Merge Subject and activity data
MergedData <- cbind(subject,activity)

# Create final dataset with subject, actviity and data
FinalData <- cbind(MergedData,features)

# use dplyr to  subjset the table with only Mean and Std deviation data

library(dplyr)
valid_column_names <- make.names(names=names(FinalData), unique=TRUE, allow_ = TRUE)
names(FinalData) <- valid_column_names
meanstdData <- select(FinalData, one_of(c("subject", "activity")),contains("mean"),contains("std"))


#Get the labels from Activity_labels file and assign the labels

activitylabels <- read.table(file.path(filepath,"UCI_HAR_Dataset","activity_labels.txt"),header = FALSE)
FinalData$activity <- factor(FinalData$activity)
levels(FinalData$activity) <- activitylabels$V2


# Rename the column names by the substring
names(FinalData)<-gsub("^t", "time", names(FinalData))
names(FinalData)<-gsub("^f", "frequency", names(FinalData))
names(FinalData)<-gsub("Acc", "Accelerometer", names(FinalData))
names(FinalData)<-gsub("Gyro", "Gyroscope", names(FinalData))
names(FinalData)<-gsub("Mag", "Magnitude", names(FinalData))
names(FinalData)<-gsub("BodyBody", "Body", names(FinalData))

# Save the final dataset into your working directory
write.table(FinalData, file = "Merged.txt",row.name=FALSE)

#Use dplyr to get the summary by the variable

TidyDataset <- FinalData %>% group_by(subject,activity) %>% summarise_each(funs(mean))

#Write the dataset to working directory

write.table(TidyDataset, file = "TidyData.txt",row.name=FALSE)

#create a cookbook into the working directory

library(memisc)
codebook(FinalData)
Write(codebook(FinalData),
      file="codebook.md")

