#feature creation

library(kernlab);
data(spam);
spam$capitalAveSq  = spam$capitalAve^2;


library(ISLR);
library(caret);
data(Wage);

#make index to data partition
inTrain <- createDataPartition(
		y=Wage$wage,
		p=0.7,
		list = FALSE);

training <- Wage[inTrain,];
test <- Wage[-inTrain,];

#convert factor variables in dummy vars

table(training$jobclass)

dummies = dummyVars(wage ~ jobclass, data=training);
head(predict(dummies, newdata=training));

#nsv
nsv = nearZeroVar(training, saveMetrics=TRUE);

#create a var polinomial
#df specify the grade of polynomial
library(splines);
bsBasis <- bs(training$age, df=3);

#fitting curves with splines

lm1 = lm(wage~bsBasis, data=training);
plot(training$age, training$wage, pch=19,cex=0.5);
points(training$age, predict(lm1, newdata=training), col="red", pch=19, cex=0.5);



predict(bsBasis, age=testing$age);
