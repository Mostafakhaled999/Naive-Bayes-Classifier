###  Part 3 (Balance your data) ###
install.packages('MLmetrics')

library(e1071)
library(caret)
library('MLmetrics')
library('dplyr')
library('caTools')
# Read the data into a table from the file
tbl  = read.table("nbtrain.csv",header=TRUE,sep=",")

# split the data into train and test 
train = as.data.frame(tbl[1:9010,])
test = as.data.frame(tbl[9011 : 10010,])

# Split the data according to gender
gender = split(train,f = train$gender)
female = as.data.frame(gender[1])
male = as.data.frame(gender[2])

# select 3500 random samples in each gender
maleSample = sample_n(male,size = 3500)
femaleSample = sample_n(female,size = 3500)

# Bind the two tables 
newTrain <- cbind(maleSample, femaleSample)

## Build the Model ##

# use NB classifier
NB = naiveBayes(income ~.,train,laplace = 0.01)

# Predict with Test Data
predicted_value = predict(NB,test)
expected_value = factor(test[,4])

#Creating confusion matrix
confuisonMatrix <- confusionMatrix(data=predicted_value, reference = expected_value)

#Display results 
confuisonMatrix
Accuracy(predicted_value,expected_value)
table(expected_value,predicted_value)
