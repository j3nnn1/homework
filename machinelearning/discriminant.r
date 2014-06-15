
data(iris)
library(ggplot2)
library(caret)
table(iris$Species)


idxTrain = createDataPartition(
		y = iris$Species,
		p=0.7,
		list=FALSE);
training = iris[idxTrain,]
testing = iris[-idxTrain,]

#discriminant analysis
ModelFitAD = train( Species ~ ., data=training, method='lda');
#naives bayes

ModelFitBAYES = train( Species ~ ., data=training, method='nb');

plda = predict(ModelFitAD, testing)
pnb = predict(ModelFitBAYES, testing)

table(plda, pnb)

#plot equal predictions
equalPredictions = (pnb==plda)
summary(equalPredictions)
qplot(Petal.Width, Sepal.Width, colour=equalPredictions, data=testing);


