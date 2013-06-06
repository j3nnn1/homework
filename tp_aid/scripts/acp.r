library("rgl")
setwd('/media/misperoles/git/homework/tp_aid')
winewhite = read.table('./data/winewithoutliers.csv', sep=',', header=T)

winewhite.acp = prcomp(winewhite[,2:12], scale=T)

#Proportion of Variance 0.2817 0.1751 0.1410 0.1103 0.08721
summary(winewhite.acp)

#acp
plot(winewhite.acp, type='l')

#biplot
biplot(winewhite.acp)

#scatterplot
ggplot(winewhite, aes(fixed.acidity, volatile.acidity)) + geom_point(colour="blue", alpha=I(0.2))

#saving components with 80% variability
df.acp = winewhite.acp$x[,1:7] 
df.acp = as.data.frame(df.acp)
df.acp$clase = winewhite$quality
write.csv(df.acp, './data/acpwith7.csv')
