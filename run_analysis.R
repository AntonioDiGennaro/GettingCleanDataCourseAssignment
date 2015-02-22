run_analysis <- function () {

# Assumption:   the file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip       
#               has been downloaded and unzipped in the current working directory.        
        
# run_analysis.R does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.        
        
        require(dplyr)
        
# reads activity labels in a data frame        
        activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activity", "activity_label"))
        message("activity labels data frame read;")
# reads features in a data frame
        features <- read.table("UCI HAR Dataset/features.txt", col.names=c("feature_id", "feature_label"), stringsAsFactors = FALSE)
        message("features data frame read;")
# reads test data

        test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=features$feature_label)
        message("raw test data frame read;")

        subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("subject"))
        message("subject_test data frame read;")

        y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("activity"))
        message("y_test data frame read;")

        test <- cbind( subject_test, y_test, test)
        message("test data frame with activity and subject columns assembled;")

# reads train data

        train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=features$feature_label)
        message("raw train data frame read;")

        subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("subject"))
        message("subject_train data frame read;")

        y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("activity"))
        message("y_train data frame read;")


        train <- cbind( subject_train, y_train, train)
        message("train data frame with activity and subject columns assembled;")

# append train and test data frames into one
        one <- rbind(train, test)
# STEP 1 of the assignment FULFILLED
        message("# 1. Merged the training and the test sets to create one data set.")

# one dataframe, with selected columns where name contains either mean or std
        one_sc <- one[grepl("mean|std", features$feature_label)]
# STEP 2 of the assignment FULFILLED
        message("# 2. Extracted only the measurements on the mean and standard deviation for each measurement. ")

# merge with activity labels
        one_sc_label <- merge(one_sc, activity_labels, by.x="activity", by.y="activity")
# STEP 3 of the assignment FULFILLED
        message("# 3. Used descriptive activity names to name the activities in the data set")

# uses the gather function to transform columns in a measure value pair for each row        
        tidy_df <- gather(one_sc, measure, value, -c(activity, subject))
# STEP 4 of the assignment fulfilled
        message ("# 4. Appropriately labelled the data set with descriptive variable names. ")
        

        final_df <- ddply(tidy_df, .(subject, activity, measure), function(x) {mean(x$value)})
        final_df_label <- merge(final_df, activity_labels, by.x="activity", by.y="activity")
        colnames(final_df_label)[4] <- "measure_mean"
        keep <- c("subject", "activity_label", "measure", "measure_mean")
        final_df_label <- final_df_label[, keep, drop=TRUE]

# STEP 5 of the assignment fulfilled
        message ("# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ")


# writes data_frame into a file
        file <- "step5_ds.txt"
        write.table(final_df_label, file=file, row.names = FALSE)
        message(paste("wrote Step 5 data set to file ", file, " in current directory"))
}