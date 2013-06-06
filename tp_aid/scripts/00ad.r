
library("rgl")
library("ggplot2")

#puttin path
setwd('/media/misperoles/git/homework/tp_aid')
winewhite = read.table('./data/winequality-white.csv', sep=';', header=T)

#matrix scatter plot
plot(winewhite, pch='.', col="#4550ea")

#histogram
g3 <- ggplot(winewhite, aes(winewhite$quality)); g3 + geom_histogram(colour = "darkgreen", fill = "white", binwidth = 0.5 )
g3 + geom_histogram(aes(y=..density..),binwidth=1,fill="white", colour = "darkgreen") + geom_density()

#boxplot about quality class
#fixed.acidity
g2 <- ggplot(winewhite, aes(factor(winewhite$quality), winewhite$volatile.acidity) ) 
g2 + geom_boxplot(outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$citric.acid) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$residual.sugar) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$chlorides) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$chlorides) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$free.sulfur.dioxide) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$total.sulfur.dioxide) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$density) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$pH) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$alcohol) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$sulphates) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

ggplot(winewhite,aes(x=factor(winewhite$quality), y=winewhite$sulphates) ) + geom_boxplot(data=winewhite, outlier.colour = "green", outlier.size = 2)  + geom_jitter()

#boxplot

bx1 <- boxplot(winewhite$volatile.acidity)  
winewhite$volatile.acidity[which(winewhite$volatile.acidity %in% bx1$out)] = NA

bx2 <- boxplot(winewhite$citric.acid)  
winewhite$citric.acid[which(winewhite$citric.acid %in% bx2$out)] = NA


bx3 <- boxplot(winewhite$residual.sugar)  
winewhite$residual.sugar[which(winewhite$residual.sugar %in% bx3$out)] = NA

bx4 <- boxplot(winewhite$chlorides)  
winewhite$chlorides[which(winewhite$chlorides %in% bx4$out)] = NA

bx5 <- boxplot(winewhite$free.sulfur.dioxide)  
winewhite$free.sulfur.dioxide[which(winewhite$free.sulfur.dioxide%in% bx5$out)] = NA

bx6 <- boxplot(winewhite$total.sulfur.dioxide)  
winewhite$free.sulfur.dioxide[which(winewhite$total.sulfur.dioxide %in% bx6$out)] = NA

bx7 <- boxplot(winewhite$density)  
winewhite$density[which(winewhite$density %in% bx7$out)] = NA

bx8 <- boxplot(winewhite$pH)  
winewhite$pH[which(winewhite$pH %in% bx8$out)] = NA

bx9 <- boxplot(winewhite$alcohol)  
winewhite$alcohol[which(winewhite$alcohol %in% bx9$out)] = NA

bx10 <- boxplot(winewhite$sulphates)  
winewhite$sulphates[which(winewhite$sulphates %in% bx10$out)] = NA

xplot(winewhite$free.sulfur.dioxide)
winewhite <- na.omit(winewhite)

#summary 
summary(winewhite)

#list all vars
#fixed.acidity, volatile.acidity citric.acid residual.sugar chlorides free.sulfur.dioxide
#total.sulfur.dioxide, density pH sulphates alcohol, :q!

#graph matrix correlations
library(gclus)
dta <-winewhite[,-12]
dta.r <- abs(cor(dta))
dta.col <- dmat.color(dta.r)
dta.o <- order.single(dta.r)
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5, pch='.',
main="Variables Ordenadas y Coloreadas por la correlación" ) 

#tabla de correlaciones
cor(dta)

#ggplot(winered, aes(fixed.acidity, volatile.acidityi, free.sulfur.dioxide)) + geom_point(colour="blue", alpha=I(0.2))
ggplot(winewhite, aes(fixed.acidity, volatile.acidity)) + geom_point(colour="blue", alpha=I(0.2))
ggplot(winewhite, aes(free.sulfur.dioxide, chlorides)) + geom_point(colour="blue", alpha=I(0.2))

#saving df without outliers
write.csv(winewhite, './data/winewithoutliers.csv')
