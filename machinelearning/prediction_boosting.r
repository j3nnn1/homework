# multiples weak predictors
# weigth by any model and average them and average them
# alpha based in the error
# fx = E(alpha * Model)
# method = gbm (trees), ada (regresition), gamBoost, mboost

library(ISRL)
library(caret)
library(ggplot2)
data(Wage)
Wage <- subset(Wage, select=-c(logWage))

idxTrain <- createDataPartition(
		y=Wage$wage,
		p=0.7,
		list=FALSE
		);
training <- Wage[idxTrain,]
testing <- Wage[-idxTrain,]

#model
ModelFit <- train(wage ~ ., method='gbm',data=training, verbose=FALSE)
print(ModelFit)

qplot(predict(ModelFit, testing), wage, data=testing)
