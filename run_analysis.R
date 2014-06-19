## This is the script for excuting the instructions of the course project of 
## Coursera course Getting and Cleaning Data

## Author: Razamut(github username)

# We assume the required data has been downloaded to the home directory. 
# Then we change the home directory to the downloaded folder using setwd("./downloaded_folder")



## part 1

# first we read the 3 files from the train folder
ftr1 <- read.table("train/X_train.txt")
ftr2 <- read.table("train/Y_train.txt")
ftr3 <- read.table("train/subject_train.txt")
names(ftr2) <- "V562" # since the automatic names of ftr1 are in the sequence V1 through 
                        # through V561, we assign names to ftr2 and ftr3 to continue the sequence 
names(ftr3) <- "V563"
traindata <- cbind(ftr1,ftr2,ftr3)
traindata[1,561:563] #checks that the names of the 562nd and 563rd 
#columns follow the naming system
ftst1 <- read.table("test/X_test.txt")
ftst2 <- read.table("test/Y_test.txt")
ftst3 <- read.table("test/subject_test.txt")
names(ftst2) <- "V562"
names(ftst3) <- "V563"
testdata <- cbind(ftst1,ftst2,ftst3)
my_data1 <- rbind(traindata,testdata)
# my_data1[1,561:563]
# tail(my_data1[,561:563])

## part 2

labels_data <- read.table("features.txt")
names_list <- as.character(labels_data[,2])
View(names_list)

rel_cols <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215227:228,
              240:241,253:254,266:271,294:296,345:350,373:375,424:429,
              452:454,503:504,516:517,526,529:530,539,542:543,552) 
# rel_cols extracts all columns the measure mean and standard deviation in the data
# the columns were obtained by visually inspecting features.txt file
# certainly there has to be a more efficient way to do this
my_data2 <- my_data1[,rel_cols] # returns a table of mean and standard deviation values
my_data2

## part 3

actvty_data <- read.table("activity_labels.txt")
my_factor <- as.factor(my_data1[,562]) # extracts the training label column and converts it into a factor
levels(my_factor) <- actvty_data[,2] # passes the descriptive activity names to the levels of the factor
# so that fac1  contains only descriptive names, without integers
my_list <- list(my_factor) # we convert it into a list in order to insert it into the table
my_data1[,562] <- my_list # replaces the training label column with the desired descriptive labels
# my_data1[1:10,561:563]   # checks the first row and last three columns 
# tail(my_data1[,561:563], n=3)  # checks the tail of last three columns
my_data1


## part 4

# labels_data <- read.table("features.txt")
# names_list <- as.character(labels_data[,2])
# head(names_list)
names_list[562] <- "activity_label"
names_list[563] <- "subject_id"
# tail(names_list)
names(my_data1) <- names_list
# my_data1[1:3,561:563]


## part 5
library(plyr)
my_tidyData <- ddply(my_data1[,1:563], 
                  .(activity_label,subject_id),
                  numcolwise(mean))
# for some reason, unknown to me at the time of writing 
# this script, applying ddply to  "my_data1" returns 
# a fewer number of columns than when applied to "my_data1[,1:563]"
# although they are both of the same class, and all 
# relevant columns are numeric in both
write.table(my_tidyData, file = "my_tidyData.txt") # writes my data to a file

