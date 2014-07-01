
library(ISLR);
library(ggplot2);
library(kernlab);
library(caret);
data(spam)


inTrain <- createDataPartition(y=spam$type, 
		p=0.75,
		list= FALSE );
training <- spam[inTrain,];
testing <- spam[-inTrain,];
hist(training$capitalAve, main='preprocessing', xlab='ave. capital run length' )

mean(training$capitalAve)

sd(training$capitalAve)

#standardizing training

trainCapAve <- training$capitalAve;
trainCapAveS <- ( trainCapAve - mean(trainCapAve))/ sd(trainCapAve)

mean(trainCapAveS)
sd(trainCapAveS)

#standardizing test

testCapAve <- testing$capitalAve;
testapAveS <- ( testCapAve - mean(trainCapAve))/ sd(trainCapAve)

mean(testapAveS)
sd(testapAveS)

#caret package standardizing
preObj <- preProcess(training[,-58], method=c('center', 'scale'));
trainCapAveS <- predict(preObj, training[, -58])$capitalAve;

mean(trainCapAveS)

trainCapAveS <- predict(preObj, testing[, -58])$capitalAve;


set.seed(32343)
modelFit <- train(type~., data=training, preProcess=c('center','scale'), method='glm');


modelFit

# data like a normal distribution
preObj <- preProcess((training[,-58], method=c('BoxCox'));
trainCapAveS <- predict(preObj, training[,-58])$capitalAve;

par(mfrow=c(1,2));

hist(trainCapAveS);
qqnorm(trainCapAveS);

#make some values na
training$capAve <- training$capitalAve;
selectNA <- rbinom(dim(training)[1], size=1, prob=0.05)==1 ;
training$capAve[selectNA] <- NA;

#impute and standardize
preObj <- preProcess(training[,-58], method='knnImpute');
capAve <- predict(preObj, training[,-58])$capAve;

#Standardize true values
capAveTruth <- training$capitalAve;
capAveTruth <- (capAveTruth - mean(capAveTruth))/sd(capAveTruth);


quantile(capAve - capAveTruth)

quantile((capAve - capAveTruth)[selectNA])

quantile((capAve - capAveTruth)[!selectNA])
