# Course-Project-for-Getting-and-Cleaning-Data
#After downloading and unzipping file
#called the dplyr package
#I used read.table to read the different data files
# I used rbind to combine the rows of train and test data and cbind to combine the code and the features as is mentioned from Part 1
# I used select and contains functions to extract only the mean and standard deviation data from Part 2
# Named the activities in the TidyData dataset from Part 3
# Used gsub function to appropriately label the TidyData dataset with descriptive variable names from Part 4
# Used %>%, group_by for subject and activity on the TidyData dataset  and summarise_all function to find average of these variables and call it a new dataset called IndependentData from Part 5
# Created a txt file for the IndependentData dataset to upload
