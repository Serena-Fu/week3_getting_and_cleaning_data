#load training data

subject.train <- read.table("train/subject_train.txt")
x.train <- read.table("train/X_train.txt")
y.train <- read.table("train/y_train.txt")

train.data <- data.frame(dataset = "training",  
		id = subject.train[,1], activity = y.train[,1], x.train)
#names(train.data)

subject.test <- read.table("test/subject_test.txt")
x.test <- read.table("test/X_test.txt")
y.test <- read.table("test/y_test.txt")

test.data <- data.frame(dataset = "testing",  
		id = subject.test[,1], activity = y.test[,1], x.test)

### answer to question #2
full.data <- rbind(train.data, test.data)
dim(full.data)


## now I need to read in all the variable names
labels <- read.table("features.txt", stringsAsFactor = F)

names(full.data)
names(full.data)[-c(1:3)] <- labels[,2]
names(full.data)

cols.needed <- grep("mean\\()|std\\()", names(full.data), value = T ) 
cols.needed

### answer to question #2
data.needed <- full.data[, c( names(full.data)[1:3], cols.needed)]

### read in activity labels

act.labels <- read.table("activity_labels.txt", stringsAsFactors = F)
### merage with data.needed
names(act.labels) <- c("activity", "act.label")
data.with.label <- merge(data.needed, act.labels)

## reorderd the cols, that's answer to question #3
data.with.label <- data.with.label[, c("id", "act.label", cols.needed)]

### quesiton #4 is aready done

### load dplyr package for question #5
library(dplyr)

aggr.data <- data.with.label %>%
	group_by(id, act.label) %>%
	summarise_each(funs(mean))
## answer to queston #5
aggr.data
	


