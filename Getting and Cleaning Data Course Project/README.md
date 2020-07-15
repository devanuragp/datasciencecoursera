---------- RUN ANALYSIS FILE INSTRUCTIONS ----------

[additional packages required -> dplyr]

BEFORE RUNNING THE FILE PLEASE SET DIRECTORY TO THE ONE CONTAINTING ALL FILES OF THE DATASET 

-> x_train is used to read as table the x_train.txt file which contains the training values for the 561 signals.
The txt file is converted into a table by xconvtolist function which returns a list of 561 variable in every row of dataframe.
That list is then used to split every element of list into corresponding column/variable. Then charater vectors and integer 
vectors are used to select columns representing any kind of mean or standard deviation and the final_x data frame is saved as csv file.

->  y_train is used to read as table the y_train.txt file which contains the training values for acitivity lables corresponding to the
readings in every row. ylabelconv is a function used to replace the numbers with their acitivity labels, using this function with apply()
function and storing the returned values as.data.frame will give us the final_y dataframe.

->  x_test is used to read as table the x_test.txt file which contains the testing values for the 561 signals. The txt file is converted
into a table by xconvtolist function which returns a list of 561 variable in every row of dataframe. That list is then used to split every
element of list into corresponding column/variable. Then charater vectors and integer vectors are used to select columns representing any
kind of mean or standard deviation and the final_x_test data frame is saved as csv file.

-> y_test is used to read as table the y_test.txt file which contains the testing values for acitivity lables corresponding to the readings
in every row. ylabelconv is a function used to replace the numbers with their acitivity labels, using this function with apply() function and
storing the returned values as.data.frame will give us the final_y_test dataframe.

-> final_df_train , final_df_test combine the final_x columns with final_y and final_x_text coulms with final_y_text.
Then combining the final_df_train and final_df_test with rows will give us the merged dataset of training and testing data. For calclulating average
all the varibles from x_train and x_test are converted from charater to numeric values.

-> For creating a short tidy dataset containing average of every variable for each of the 6 activities out of this existing dataset, a dataframe
for every activity is created containg only the average of all variables. Then a transpose of rowbinding dataframes of all activities is saved as
final_short. "Avg_" is added in front of every variable and the final_short is saved as both a csv and txt file.

-> IN THE LAST LINE OF CODE PLEASE ADD YOUR PATH AND UNCOMMENT THE write.table() line to export the dataset 
