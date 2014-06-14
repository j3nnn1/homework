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

dummy = dummyVars(wage ~ jobclass, data=training);
head(predict(dummies, newdata=training)



