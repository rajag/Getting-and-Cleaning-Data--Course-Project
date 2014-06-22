#  Getting and Cleaning Data: Cource Project  #
## CodeBook ##
### tidydata01.csv ### 

Consists of 10299 observations and 81 variables. The variables are descriptivly names.
The first 7352 and following 2947 observations are the training and test data, respectively.
The first variable shows the LabelID representing the activity, which can be found in readable form in second variable.
The other variables are copied from the provided dataset and where picked according if they contain "mean" or "std" according to task 2.

### tidydata02.csv ###
Consists of 180 observations and all variables (561) plus one variable for the subjectID and one variable for the activityID.
For every subject the mean of every variable to the appropriate activity was calculated. I.e. 30 subjects and 6 activities build up the 180 observations.
The variable names are descriptively named.
