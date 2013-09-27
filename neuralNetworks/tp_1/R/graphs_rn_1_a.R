
library("ggplot2");
library("MASS");

rn = read.table('../data/RN_clima_numerico_1_a.csv.data', sep=',', header=T)

best_indx = which(rn$Ite < rn$Max_It, arr.ind=TRUE)

#alfa vs Max_Ite
qplot(rn$alfa[best_indx] , rn$Ite[best_indx], xlab='Alfa', ylab='Última Iteración')

#success vs alfa
qplot(rn$alfa[best_indx],rn$Aciertos[best_indx], xlab='Alfa', ylab='Aciertos')
