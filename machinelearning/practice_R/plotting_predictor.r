
library(ISLR);
library(ggplot2);
library(caret);
data(Wage)
summary(Wage)


inTrain <- createDataPartition(y=Wage$wage, 
		p=0.7,
		list= FALSE );

training <- Wage[inTrain,];
testing <- Wage[-inTrain,];

dim(testing)
dim(training)


featurePlot(x=training[, c('age', 'education', 'jobclass')],
	    y=training$wage,
	    plot="pairs");

qplot(age, wage, data=training, colour=jobclass)
qq  <- qplot(age, wage, data=training, colour=education)
qq + geom_smooth(method='lm', formula=y~x)


#cut in a groups, to plot
cutWage <- cut2(training$wage, g=3)
table(cutWage)

qplot(cutWage, age, data=training, fill=cutWage, geom=c('boxplot', 'jitter'))
p1 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c('boxplot', 'jitter'))
p2 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c('boxplot', 'jitter'))
#grid.arrange(p1,p2,ncol=2)

t1 <- table(cutWage, training$jobclass)
t1
prop.table(t1, 1)

#density plot
qplot (wage, colour=education, data=training, geom="density" )

#plot only training data test not is for data exploration





