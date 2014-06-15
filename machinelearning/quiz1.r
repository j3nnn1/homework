
#library(AppliedPredictiveModeling)
#data(concrete)
#library(caret)
#set.seed(975)
#inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
#training = mixtures[ inTrain,]
#testing = mixtures[-inTrain,]
#library(Hmisc)
#
#factorCement = cut2(mixtures$Cement, levels.mean=TRUE)
#factorFlyAsh = cut2(mixtures$FlyAsh, levels.mean=TRUE)
#factorAge = cut2(mixtures$Age, levels.mean=TRUE)
#factorAge
#plot (mixtures$CompressiveStrength, col=c(factorAge))
#plot (mixtures$CompressiveStrength, col=c(factorFlyAsh))

#doing PCA

#set.seed(3433)
#library(AppliedPredictiveModeling)
#library(caret)
#data(AlzheimerDisease)
#adData = data.frame(diagnosis,predictors)
#inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
#training = adData[ inTrain,]
#testing = adData[-inTrain,]
#
#x <- prcomp(training[,57:68]);
#preProc <- preProcess(training[,57:68], method='pca', thresh=0.8);
#trainingPCA <- predict(preProc, log10(training[,-58] + 1));
#
#summary(preProc)
#
#plot (trainingPCA[,1], trainingPCA[,2], col=typeColor);

set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

#model with PCA
preProc <- preProcess(training[,57:68], method='pca', thresh=0.8);
trainingPCA <- predict(preProc, training[,57:68]);
modelFit <- train(training$diagnosis ~ ., method='glm', data=trainingPCA );

testingPCA <- predict(preProc, testing[,57:68]) 
confusionMatrix(testing$diagnosis, predict(modelFit, testingPCA));


#model without PCA
modelFit <- train(training$diagnosis ~ ., method='glm', data=training[,57:68] );
confusionMatrix(testing$diagnosis, predict(modelFit, testing[,57:68]));

#WITH PCA
#Confusion Matrix and Statistics

#          Reference
#Prediction Impaired Control
#  Impaired        6      16
#  Control         4      56
#                                          
#               Accuracy : 0.7561          
#                 95% CI : (0.6488, 0.8442)
#    No Information Rate : 0.878           
#    P-Value [Acc > NIR] : 0.99932         
#                                          
#                  Kappa : 0.2491          
# Mcnemar's Test P-Value : 0.01391         
#                                          
#            Sensitivity : 0.60000         
#            Specificity : 0.77778         
#         Pos Pred Value : 0.27273         
#         Neg Pred Value : 0.93333         
#             Prevalence : 0.12195         
#         Detection Rate : 0.07317         
#   Detection Prevalence : 0.26829         
#      Balanced Accuracy : 0.68889         
#                                          
#       'Positive' Class : Impaired   
##WITHOUT PCA
#
#Confusion Matrix and Statistics
#
#          Reference
#Prediction Impaired Control
#  Impaired        6      16
#  Control        11      49
#                                          
#               Accuracy : 0.6707          
#                 95% CI : (0.5581, 0.7706)
#    No Information Rate : 0.7927          
#    P-Value [Acc > NIR] : 0.9967          
#                                          
#                  Kappa : 0.0963          
# Mcnemar's Test P-Value : 0.4414          
#                                          
#            Sensitivity : 0.35294         
#            Specificity : 0.75385         
#         Pos Pred Value : 0.27273         
#         Neg Pred Value : 0.81667         
#             Prevalence : 0.20732         
#         Detection Rate : 0.07317         
#   Detection Prevalence : 0.26829         
#      Balanced Accuracy : 0.55339         
#                                          
#       'Positive' Class : Impaired        
#                                     
#
#
###
