library(caret);
library(kernlab);
data(spam);

inTrain <- createDataPartition(
	y=spam$type,
	p=0.7,
	list=FALSE);

training <- spam[inTrain,];
test <- spam[-inTrain,];


M <- abs(cor(training[,-58]))

diag(M) <- 0

which(M>0.8, arr.ind=T)

names(spam)[c(32,34)]

#PCA
plot(spam[,32], spam[,34])

X <- 0.71*training$num415 + 0.71 * training$num857;
Y <- 0.71*training$num415 - 0.71 * training$num857;

plot(X,Y);

# PCA
smallSpam <- spam[,c(32,34)];
pca <- prcomp(smallSpam);
plot(pca$x[,1], pca$x[,2]);

pca$rotation;


typeColor <- ((spam$type=="spam") * 1  + 1)
pca <- prcomp(log10(spam[,-58] + 1));

plot (pca$x[,1], pca$x[,2], col=typeColor, xlab='PC1', ylab='PC2');

#doing preprocess with caret and pca

preProc <- preProcess(log10(spam[,-58] + 1), method='pca', pcaComp=2);
spamPC <- predict(preProc, log10(spam[,-58] + 1));

plot (spamPC[,1], spamPC[,2], col=typeColor); 

#doing pca preprocess with data

preProc <- preProcess(log10(training[,-58] + 1), method='pca', pcaComp=2);

preProc$dim
summary(preProc)
head(preProc$pcaComp)

trainPC <- predict(preProc, log10(training[,-58] + 1));

trainPC
modelFit <- train(training$type ~ ., method='glm', data=trainPC);

modelFit

testPC <- predict(preProc, log10(testing[,-58] + 1));
confusionMatrix(testing$type, predict(modelFit, testPC));

is(preProc)
head(preProc)

#another simple way to train a model with preprocess

modelFit <- train(training$type ~., method='glm', preProcess='pca',data=training );

confusionMatrix(testing$type, predict(modelFit, testing))
