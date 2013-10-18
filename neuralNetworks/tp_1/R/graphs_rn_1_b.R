
library("ggplot2");
library("MASS");

rn = read.table('../data/RN_clima_numerico_1_a.csv.data', sep=',', header=T)

best_indx = which(rn$Ite < rn$Max_It, arr.ind=TRUE)

#alfa vs Max_Ite
qplot(rn$alfa[best_indx] , rn$Ite[best_indx], xlab='Alfa', ylab='Última Iteración')

#success vs alfa
qplot(rn$alfa[best_indx],rn$Aciertos[best_indx], xlab='Alfa', ylab='Aciertos')

#success vs Ite y color x alfa
#sin scalar.
subset = data.frame(alfa=rn$alfa[best_indx], success=as.factor(rn$Aciertos[best_indx]), ite=rn$Ite[best_indx], check.rows = FALSE)
subset = data.frame(alfa=rn$alfa, success=as.factor(rn$Aciertos), ite=rn$Ite, check.rows = FALSE)
subset = apply(subset, 2, as.numeric)
unique(subset[,1])
apply(subset[subset[,1]==5.0000e-01,], 2, mean)
apply(subset[subset[,1]==4.0000e-01,], 2, mean)
apply(subset[subset[,1]==3.0000e-01,], 2, mean)
apply(subset[subset[,1]==2.0000e-01,], 2, mean)
apply(subset[subset[,1]==1.0000e-01,], 2, mean)
apply(subset[subset[,1]==-2.7756e-17,], 2, mean)
apply(subset[subset[,1]==-5.0000e-01,], 2, mean)
subset = read.table('../data/RN_adult_promedio_NOnormalize.csv', sep=',', header=T)
#subset = data.frame(alfa=rn$alfa[best_indx], success=as.factor(rn$Aciertos[best_indx]), ite=rn$Ite[best_indx], check.rows = FALSE)
ggplot(subset, aes(y=subset$alfa, x=subset$iteracion)) + geom_line(size=1, aes(colour= subset$iteracion)) + geom_point(size=2, aes(colour=subset$aciertos)) + xlab('Iteracion') + ylab('Alfa')

ggplot(subset, aes(y=subset$success, x=subset$ite)) + geom_point(size=3, aes(colour= subset$alfa))

