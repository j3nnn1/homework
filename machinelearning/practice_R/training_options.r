library(caret)
library(kernlab)
data(spam)
inTrain <- createDataPartition(
	y = spam$type,
	p=0.75,
	list = FALSE);

##how to doit random subset
training <- spam[inTrain,]
testing <- spam[-inTrain,]

dim(testing)
dim(training)

#see params in a function

args(train.default)
# preProcess => options preprocesing see later 
# weights to manage unbalanced dataset (if I have a dataset 98% y 2% and the interest is in 2%)
# metric , metrics Accuracy or RMSE R square 
#

args(trainControl)

# method = boot | crossvalidation | resampling
# method = boot | boot632 (con ajuste) | cv | repeatedcv | LOOCV (leave one out cross validation)
# number = number of subsamples to take
# repeat = number of time to repeat subsampling and if this is big could be slooooow
# allowParallel = true multiples cores

modelFit <- train(type ~ ., data=training, method="glm")
modelFit

modelFit$finalModel

predictions <- predict(modelFit, newdata=testing)
predictions

confusionMatrix(predictions, testing$type)
