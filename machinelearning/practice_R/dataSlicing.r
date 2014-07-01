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


#crossvalidation
set.seed(32343)
folds <- createFolds(y=spam$type, k=10, list=TRUE, returnTrain=TRUE)
sapply(folds, length)

#resampling
folds <- createResample(y=spam$type, times=10, list=TRUE)
sapply(folds, length)


#timeSlices
tme <- 1:1000
folds <- createTimeSlices(y=tme, initialWindow=20, horizon=10)
names(folds)

modelFit <- train(type ~ ., data=training, method="glm")
modelFit

modelFit$finalModel

predictions <- predict(modelFit, newdata=testing)
predictions

confusionMatrix(predictions, testing$type)
