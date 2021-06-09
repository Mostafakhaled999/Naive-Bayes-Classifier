###  Part 2 (Predict individual’s gender) ###
install.packages('MLmetrics')

library(e1071)
library(caret)
library('MLmetrics')
# Read the data into a table from the file

tbl  = read.table("nbtrain.csv",header=TRUE,sep=",")
#print(tbl)

# split the data into train and test 
train = as.data.frame(tbl[1:9010,])
test = as.data.frame(tbl[9011 : 10010,])


## Build the Model ##

# use NB classifier
NB = naiveBayes(gender ~.,train,laplace = 0.01)

# Predict with Test Data
predicted_value = predict(NB,test)
expected_value = factor(test[,2])

#Creating confusion matrix
confuisonMatrix <- confusionMatrix(data=predicted_value, reference = expected_value)

#Display results 
confuisonMatrix
Accuracy(predicted_value,expected_value)
table(expected_value,predicted_value)
