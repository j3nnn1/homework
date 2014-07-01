
library(caret);
library(ISLR);
library(ggplot2);
data(Wage);
Wage <- subset(Wage, select=-c(logwage));
summary(Wage);

index <- createDataPartition(y=Wage$wage,
			p=0.7,
			list=FALSE);
training <- Wage[index,];
testing <- Wage[-index,];

dim(training);
dim(testing);

featurePlot(x=training[, c('age','education','jobclass')],
		y=training$wage,
		plot="pairs");

qplot(age, wage, data=training);
qplot(age, wage, data=training, colour=jobclass);
qplot(age, wage, data=training, colour=education);

#use some covariates
modelFit <- train(wage ~ education + jobclass + age, 
		method='lm',
		data=training);

modelFit$finalModel
print(modelFit)
plot(modelFit$finalModel, pch=19, cex=0.5, col='#00000010');

qplot(modelFit$finalModel$fitted, modelFit$finalModel$residuals, colour=race, data=training);

#residual vs index, could show if any vars is missing, or some relation between vars
# dont be show residuals from a num rows/ no debería mostrar Todos los residuales a partir de un numero de fila
# en este caso los residuales aparecen en las ultimas filas.
plot(modelFit$residuals, pch=19)

#preditions vs trust in test
pred <- prediction(modelFit$finalModel, testing);

qplot(wage, pred,colour=yaer, data=testing);

#use all covariates

modelFit <- train(wage ~ .,
		method='lm',
		data=training);


pred <- prediction(modelFit$finalModel, testing);

qplot(wage, pred,colour=yaer, data=testing);
