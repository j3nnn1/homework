library(caret)
library(ggplot2)

idxTrain <- createDataPartition(y = iris$Species,
		p=0.7,
		list=FALSE);
training <- iris[idxTrain,];
testing <- iris[-idxTrain,];

# model
ModelFit <- train(Species~.,data=training, method='rf', prox=TRUE);

getTree(ModelFit$finalModel, k=2)

irisP <- classCenter(training[,c(3,4)], training$Species, ModelFit$finalModel$prox);
irisP <- as.data.frame(irisP);
irisP$Species <- rownames(irisP);
p <- qplot(Petal.Width, Petal.Length, col=Species, data=training);
p + geom_point(aes(x = Petal.Width, y= Petal.Length, col=Species), size=5, shape=4, data=irisP);

predicted <- predict(ModelFit, testing)
table(predicted, testing$Species)

#plot with row that I miss
testing$predRight <- predicted == testing$Species;
qplot(Petal.Width, Petal.Length, colour=predRight, data=testing, main='new data Predictions')

