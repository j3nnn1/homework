
data(iris)
library(ggplot2)
library(caret)
names(iris)
table(iris$Species)

indexTraining <- createDataPartition(y=iris$Species,
				p=0.7,
				list=FALSE);
training <- iris[indexTraining,];
testing <- iris[-indexTraining,];

dim(testing)
dim(training)

qplot(Petal.Width, Sepal.Width, colour=Species, data=training)

#model
ModelFit = train(Species ~., method="rpart", data=training);
print (ModelFit)

plot(ModelFit$finalModel, uniform=TRUE, main='Clasification Tree')
text(ModelFit$finalModel, use.n=TRUE,all=TRUE,cex=.8)

#a fancy plot
#library(rattle)
#library(rpart)
#fancyRpartPlot(ModelFit$finalModel)

predict(ModelFit, newdata=testing)

