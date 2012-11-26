library(MASS)

setwd('/media/misperoles/git/homework/tp_aid')
winewhite = read.table('./data/acpwith7.csv', sep=',', header=T)

wine <- winewhite[,2:8]; 

fit <- lda(winewhite[,9] ~ ., data = wine, CV=TRUE,  na.action="na.omit")

ct <- table(winewhite$clase, fit$class)
diag(prop.table(ct, 1))
sum(diag(prop.table(ct)))


#verificacion de supuestos
#homogeneidad de las varianzas y covarianzas.
#Normalidad
#Independencia
