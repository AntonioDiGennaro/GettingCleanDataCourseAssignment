# Codebook #

This is a code book that describes the variables, the data, and any transformations or work performed to clean up the data.

## Assumption ##

run_analysis.R assumes that the .zip file containing the raw data has been downloaded and unzipped in the current working directory.

## Step by Step ##

It will issue a message on the console at some significant points to show progress.

It starts loading 2 data frames:

1.  activity_labels;
1.  features.

It proceeds then to load the data frames test and train with similar instructions:

1.  it loads the raw data;
1.  it loads the activity data;
1.  it loads the subject data;
1.  it assembles the data frame adding the activity, subject and all the raw data columns in this order.

It then appends the train and test data sets into a data frame called one.

This fulfills STEP #1 of the assignment.

---

It identifies in the  'one' data frame the columns whose name contains either 'mean' or 'std' using a simple regular expression
it creates another data frame called 'one_sc' ( where sc stands for selected columns) with only such columns.

This fulfills STEP #2 of the assignment.

---

It then joins 'one_sc' with 'activity_labels' to replace the numeric activity IDs with a more descriptive name.

This fulfills STEP #3 of the assignment.

---

It then generates a 'tidy_df' data frame, to convert columns with values for a specific measure into rows, so that each row has one single observation of variable.
The columns are already appropriately labelled and this fulfills STEP #4 of the assignment.

---

Finally, the data frame is processed using the ddply function, to split it into groups with the same subject, activity_label and measure to calculate the mean on the value column and then reassemble the results into a data frame called final_df.

The column with the calculation of the mean is renamed and then the activity labels data frame merged to fulfill STEP #5 of the assignment.

---

As a last step, the script writes the data frame final_df into a text file to allow then the upload as requested by the course assignment.

## List of Variables ##

* activity_labels: data frame used to keep the table with the association between activity ids and activity labels;

* features: data frame used to keep the table with the association between feature ids and feature labels;

* test: data frame used to keep the raw test data and then reused to keep the test data with 2 additional columns for the subject and activity;

* train: data frame used to keep the raw train data and then reused to keep the train data with 2 additional columns for the subject and activity;

* one: append of test and train data frames;

* one_sc: data frame with a subset of columns with respect to one data frame, only those carrying a mean or a standard deviation; 

* one_sc_label: data frame with activity labels;

* tidy_df: data frame obtained unpivoting the one_sc data set using the gather function

* final_df: data frame with the mean of measures by subject and activity;

* final_df_label: same as final_df but with activity labels instead of ids.

