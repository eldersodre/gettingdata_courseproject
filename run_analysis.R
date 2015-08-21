#########################################################################
############## Getting and Cleaning Data - Course Project ###############
#########################################################################

##### Attachng packages ####
library(dplyr)
library(tidyr)


##### Data input into R ####

xtest <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
xtest #Test data


ytest <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\Y_test.txt")
ytest <- as.factor(ytest[,1]) 
ytest #Activity (test data)


stest <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt")
stest <- stest[,1] 
stest #Subject number (test data)


xtrain <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
xtrain #Train data


ytrain <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\Y_train.txt")
ytrain <- as.factor(ytrain[,1])
ytrain #Activity (train data)

strain <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt")
strain <- strain[,1]
strain #Subject number (train data)


test <- cbind(subject=stest,activity=ytest,xtest)
test #Full test date

train <- cbind(subject=strain,activity=ytrain,xtrain)
train #Full train data


feat <- read.table(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\features.txt")
feat <- as.character(feat[,2])
feat #Features (will be used as column names)


#### Merge the training and the test sets to create one data set ####


full.data <- rbind(test,train) %>%  #Merge data
  arrange(subject,activity)         #Rearrange data according to subject and activity


#### Extract only the measurements on the mean and standard deviation for each measurement ####

means <- grepl("mean()",feat,fixed=T)
means #Logical vector containing the position of means. 
#Argument fixed=T was used to exclude mean frequencies, including only mean values.

stds <- grepl("std",feat)
stds #Logical vector containing the position of standard deviations.


data2 <- select(full.data,-subject,-activity)

data2 <- data2[,means|stds]

data2 

#### Use descriptive activity names to name the activities in the data set ####

data3 <- cbind(full.data[,c(1,2)],data2)

data3$activity <- factor(data3$activity,labels=c("walking","walking_upstairs","walking_downstairs","sitting","standing","laying"))

data3 #Data with descriptive activity names.


#### Appropriately labels the data set with descriptive variable names ####

colnames(data3) <- c("subject","activity",feat[means|stds])


#### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject ####

tidy.data <- aggregate(data3[,3:68],data3[,1:2],mean) %>% 
  #Above : creates data set with the average of each variable for each activity and each subject
  gather(variable,value,-subject,-activity) %>%
  separate(variable,into=c("movement","statistics","axis")) #Making the data set tidy.

write.table(tidy.data,"tidydata.txt",row.names=F)

