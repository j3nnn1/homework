library(ISLR)
library(caret)
library(ggplot2)
data(Wage)

Wage <- subset(Wage, select=-c(logwage))

#create a building data set AND validation set 
inBuild <- createDataPartition(
		y=Wage$wage,
		p=0.7,
		list = FALSE);

validation <- Wage[-inBuild,]; #30% del 100% All Data
buildData <- Wage[inBuild,];

inTrain <- createDataPartition(
		y=buildData$wage,
		p=0.7,
		list = FALSE );
training <- buildData[inTrain,]; #70% del 70% de BuildData
testing <- buildData[-inTrain,]; #30% del 70%

dim(training)
dim(validation)
dim(testing)

mod1 <- train(wage~., method="lm", data=training)
mod2 <- train(wage ~., method='rf', data=training, trControl=trainControl(method='cv', number=3))

#predict on testing
pred1 <- predict(mod1, testing)
pred2 <- predict(mod2, testing)

qplot(pred1, pred2, colour=wage, data=testing)

#Fit a model that combine this two predictors

preDF = data.frame(pred1, pred2, wage=testing$wage)
combModFit = train(wage ~.,method='gam', data=preDF)
combPred = predict(combModFit, preDF)

#error rate

sqrt(sum(pred1 - testing$wage)^2)
sqrt(sum(pred2 - testing$wage)^2)
sqrt(sum(combPred - testing$wage)^2)

#predic on validation dataset

pred1V = predict(mod1, validation)
pred2V = predict(mod2, validation)
predVDF  = data.frame(pred1 = pred1V, pred2=pred2V, wage=validation$wage)
predCombV = predict(combModFit, predVDF)


#error rate
sqrt(sum(pred1V - validation$wage)^2)
sqrt(sum(pred2V - validation$wage)^2)
sqrt(sum(predCombV - validation$wage)^2)

