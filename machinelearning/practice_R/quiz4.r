
#library(ElemStatLearn)
#data(vowel.train)
#data(vowel.test)
#library(caret)

#vowel.train$y = as.factor(vowel.train$y)
#vowel.test$y = as.factor(vowel.test$y)

#set.seed(33833)

#modelFitRF= train(y~., data=vowel.train, method="rf", prox=TRUE)
#modelFitGBM= train(y~., data=vowel.train, method="gbm")
#
#modelFitRF
##accuracy 0.934 in train
# Accuracy : 0.6061   in testing
#predRF = predict(modelFitRF, vowel.test)
#confusionMatrix(predRF, vowel.test$y) 
#modelFitRF
#modelFitGBM
##accuracy 0.8683489
# accuracy 0.53
#predGBM = predict(modelFitGBM, vowel.test)
#confusionMatrix(predGBM, vowel.test$y) 
#
#library(caret)
#qplot(predGBM, predRF, data=vowel.test, colour=vowel.test$y);
#AgreementAccuracy

#newX = data.frame(pred1 = predRF, pred2=predGBM, y=vowel.test$y)
#ModelFitAgreement = train(y~.,data=newX, method="rf")
#predAgrement = predict(ModelFitAgreement,newX) 
#confusionMatrix(predAgrement, vowel.test$y) 
#
#Question 2
#set.seed(3433)
#library(AppliedPredictiveModeling)
#data(AlzheimerDisease)
#adData = data.frame(diagnosis,predictors)
#inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
#training = adData[ inTrain,]
#testing = adData[-inTrain,]
###
##set.seed(62433)
##
#modelFitRF= train(diagnosis~., data=training, method="rf")
#modelFitGBM= train(diagnosis~., data=training, method="gbm")
#modelFitLDA= train(diagnosis~., data=training, method="lda")
##
#predRF = predict(modelFitRF, testing)
#predGBM = predict(modelFitGBM, testing)
#predLDA = predict(modelFitLDA, testing)
##
##confusionMatrix(predRF, testing$diagnosis) #accuracy 0.7683
#confusionMatrix(predGBM, testing$diagnosis) #accuracy 0.8049
#confusionMatrix(predLDA, testing$diagnosis) #accuracy 0.7683
##
#newX = data.frame(pred1=predRF, pred2=predGBM, pred3=predLDA, diagnosis=testing$diagnosis)
#modelFitAgreement = train(diagnosis~.,data=newX, method="rf")
#predAgrement = predict(modelFitAgreement,newX)
#confusionMatrix(predAgrement, testing$diagnosis) 
#### Stacked Accuracy 0.8293
#
#Question IV
#set.seed(3523)
#library(AppliedPredictiveModeling)
#library(caret)                                                                                                                                                           
#library(lars)                                                                                                                                                           
#data(concrete)
#inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
#training = concrete[ inTrain,]
##testing = concrete[-inTrain,]
#
#set.seed(233)
#x = as.matrix(training[,-9])
##x = apply(x, 2, as.numeric)
#y = as.numeric(training$CompressiveStrength)
#lasso.fit.caret <- train(x, y, method="lasso")
#lasso.fit <- lars(x, y, type=c("lasso"), trace=TRUE, normalize=TRUE)
#
##fit lasso model
#
#question V

set.seed(3523)
library(AppliedPredictiveModeling)
library(e1071)
library(caret)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
set.seed(325)
modelFitSVM = svm(training, training$CompressiveStrength)
#
#x = training[,-ncol(training)]
#x_test  = training[,-ncol(testing)]
#
predSVM = predict(modelFitSVM,testing, decision.values=TRUE)
#sqrt(sum(predSVM - testing$CompressiveStrength)^2)
#sqrt(sum(predSVMnum - testing$CompressiveStrength)^2)
#sqrt(mean(predSVMnum - testing$CompressiveStrength)^2)


