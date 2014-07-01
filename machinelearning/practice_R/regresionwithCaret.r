
library(caret)
data(faithful)
set.seed(333)
inTrain <- createDataPartition(
		y=faithful$waiting,
		p=0.5,
		list=FALSE);
training <- faithful[inTrain,];
test <- faithful[-inTrain,];

head(training);

plot(
training$waiting,
training$eruptions,
pch=19,
col="blue",
xlab="Waiting",
ylab="Duration");

lm1 <- lm(eruptions ~ waiting, data=training);

summary(lm1);

lines(training$waiting, lm1$fitted, lwd=3);

#predicting a new value
coef(lm1)[1] + coef(lm1)[2] * 80
newdata = data.frame(waiting=80)
predict(lm1, newdata)

#plot training vs testing
par(mfrow=c(1,2))
plot(
training$waiting,
training$eruptions,
pch=19,
col="blue",
xlab="Waiting",
ylab="Duration");

lines(training$waiting, predict(lm1, training), lwd=3);

plot(
test$waiting,
test$eruptions,
pch=19,
col="blue",
xlab="Waiting",
ylab="Duration");

lines(test$waiting, predict(lm1, newdata=test), lwd=3);

#set errors
sqrt(sum((lm1$fitted - training$eruptions)^2))
sqrt(sum((predict(lm1, newdata=test) - test$eruptions)^2))

#predictions interval - confidence


pred1 <- predict(lm1, newdata=test, interval="prediction");
ord = order(test$waiting);
plot(test$waiting, test$eruptions, pch=19, col="blue");
matlines(test$waiting[ord], pred1[ord,], type='l',, col=c(1,2,2), lty=c(1,1,1), lwd=3);

#regretion with caret

ModelFit <- train(eruptions~waiting, data=training, method='lm');
summary(ModelFit);
