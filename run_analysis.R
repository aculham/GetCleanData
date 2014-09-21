
##### STEP 1: Merges the training and the test sets to create one data set.

### Read the train data
y_train=read.table( "train/y_train.txt" )
x_train=read.table( "train/x_train.txt" )
subject_train=read.table( "train/subject_train.txt" )

### Read the test data
y_test=read.table( "test/y_test.txt" )
x_test=read.table( "test/x_test.txt" )
subject_test=read.table( "test/subject_test.txt" )

### Read some misc stuff
activity_labels = read.table( "activity_labels.txt" )
features = read.table( "features.txt" )

### Combine the train and test sets
y_all = rbind( y_train, y_test )
x_all = rbind( x_train, x_test )
subject_all = rbind( subject_train, subject_test )

### Add the column names now since everything is the same size
colnames( y_all ) = "activityID"
colnames( x_all ) = features[,2]
colnames( subject_all ) = "subjectID"

### Now combine all of them into one
data = cbind( subject_all, y_all, x_all )

##### STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

### Need to find all features with mean() or std()
meanIdx = which( grepl("mean()",features[,2]) )
stdIdx = which( grepl("std()",features[,2]) )

### Only extract those features
### Also need the first two colums - offset idx vars by 2
data = data[, c( 1, 2, meanIdx + 2, stdIdx + 2 ) ]



##### STEP 3: Uses descriptive activity names to name the activities in the data set

### Look up what the activity is using the ID
activities = sapply( y_all[,1], function(x){ activity_labels[x,2] } )


### Now replace the activity ID column in data
data[,2] = activities
colnames( data )[2] = "activity"


##### STEP 4: Appropriately labels the data set with descriptive variable names. 
### For some reason I couldn't quite get this work at this stage
### However, it turns out to be easier to do above anyway, when we have all the columns still



### STEP 5: From the data set in step 4, creates a second, independent tidy data 
###         set with the average of each variable for each activity and each subject.

### use the sqldf library
library( sqldf )

### First we have to melt the data, to make it more query friendly
library( reshape2 )
melted_data = melt( data, id = c( "subjectID", "activity") ) 
colnames( melted_data )[3] = "feature"

### Simple SQL statement
sql = "SELECT subjectID, activity, feature, avg( value ) as avgValue " 
sql = paste( sql, "FROM melted_data GROUP BY subjectID, activity, feature", sep="" )

### Execute the SQL
final_data = sqldf( sql )




