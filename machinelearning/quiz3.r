
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)

#(2019, 119)
dim(segmentationOriginal)
summary(segmentationOriginal)
names(segmentationOriginal)

idxTrain = (segmentationOriginal$Case=='Train')

training = segmentationOriginal[idxTrain,]
testing = segmentationOriginal[-idxTrain,]

dim(training)
dim(testing)

set.seed(125)
ModelFit = train(Class ~., method="rpart", data=training);

print(ModelFit$finalModel)
#Model
#          CP nsplit rel error
#1 0.32975871      0 1.0000000
#2 0.16085791      1 0.6702413
#3 0.03485255      2 0.5093834
#
#$method
#[1] "class"
#
##> print(ModelFit$finalModel)
#n= 1009 
#
#node), split, n, loss, yval, (yprob)
#      * denotes terminal node
#
#1) root 1009 373 PS (0.63032706 0.36967294)  
##  2) TotalIntenCh2< 45323.5 454  34 PS (0.92511013 0.07488987) *
#  3) TotalIntenCh2>=45323.5 555 216 WS (0.38918919 0.61081081)  
#    6) FiberWidthCh1< 9.673245 154  47 PS (0.69480519 0.30519481) *
#    7) FiberWidthCh1>=9.673245 401 109 WS (0.27182045 0.72817955) *
##predict for these values
a = data.frame(TotalIntenCh2=23000, FiberWidthCh1=10, PerimStatusCh1=2) # PS
b = data.frame(TotalIntenCh2=50000, FiberWidthCh1=10, VarIntenCh4=100)  # WS
c = data.frame(TotalIntenCh2=57000, FiberWidthCh1=8, VarIntenCh4=100)   # PS
d = data.frame(FiberWidthCh1=8, VarIntenCh4=8, PerimStatusCh1=2) #no lo clasifica

plot(ModelFit$finalModel, uniform=TRUE, main='Clasification Tree')
text(ModelFit$finalModel, use.n=TRUE, all=TRUE,cex=.8)

#question two
#pgm is not available for 3.1.0
library(pgmm)
library(tree)
data(olive)
olive = olive[,-1]

Modeltree = tree(Area ~., olive)
newdata = as.data.frame(t(colMeans(olive)))
predict(Modeltree, newdata)

#with all class inclusive
#predict(Modeltree, newdata) 
#       1 
#7.515789 

#without class Area
#predict(Modeltree, newdata)  
#    1 
#2.875 

#question4
#
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
#SAheart$chd = as.factor(SAheart$chd)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)

#logistic regression

modelFit <- train(trainSA$chd ~ age + alcohol + obesity + tobacco + typea + ldl, method='glm', data=trainSA, family='binomial');

pre_test = predict(modelFit, testSA)
pre_train = predict(modelFit, trainSA)

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

#testing
missClass(testSA$chd, pre_test)
missClass(trainSA$chd, pre_train)

#five question

library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y = as.factor(vowel.train$y)
vowel.test$y = as.factor(vowel.test$y)
set.seed(33833)

ModelFit <- train(y~.,data=vowel.train, method='rf', prox=TRUE);

varImp(ModelFit)








