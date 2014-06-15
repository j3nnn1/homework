
#bootstrap aggregating
#resample case so could reduced variance
#useful in no linear function

library(ElemStatLearn)
data(ozone, package='ElemStatLearn')
ozone <- ozone[order(ozone$ozone), ]
head(ozone)

## balance in bias in training and test
dim(ozone)
# 4 111

#each row is a model
ll <- matrix(NA, nrow=10, ncol=155)

for (i in 1:10) {
	#resample 10 different times
	indexss <- sample(1:dim(ozone)[1], replace=T)
	#subsets
	ozone0 <-ozone[indexss, ];
	ozone0 <- ozone0[order(ozone0$ozone),] 
	#model
	loess0 <-loess(temperature ~ozone, data=ozone0, spam=0.2)
}

plot(ozone$ozone, ozone$temperature, pch=19, cex=0.5)
for(j in 1:10) { 
	j
	#ten models
	lines(1:155, ll[j,], col="blue", lwd="2");
}
#average
lines(1:155, apply(ll, 2, mean),  col="red", lwd="2");
head(ll[1,])

#custom bagging with Caret
#caret packages has bagging, method [bagEarth, treebag, bagFDA]]
library(caret)
predictors <- data.frame(ozone=ozone$ozone)
temperature <- ozone$temperature
treebag <- bag(
	predictors,
	temperature,
	B=10, #quantity models
	bagControl = bagControl (fit = ctreeBag$fit, #method 
				predict = ctreeBag$pred, 
				aggregate = ctreeBag$aggregate #average to put together 
				));

plot(ozone$ozone, temperature, col="lightgrey", pch=19)
points(ozone$ozone, predict(treebag$fit[[1]]$fit, predictors), pch=19, col="red")
points(ozone$ozone, predict(treebag, predictors), pch=19, col="blue")

#parts of the bagging function

ctreeBag$fit
ctreeBag$pred
ctreeBag$aggregate

#bagging could has a extension like random forest


 
