library("tm")
library("caret")
library("ipred")
#1 leer datos.
df.merge = read.table('./textos tm/output/dataclaseconpensadores.csv', sep=',', header=T)

#2 eliminando primera columna
df.merge[1]<- NULL

#2 parametro de entrada para crear un modelos que admita cross validation con caret
fitControl <- trainControl(method = "repeatedcv",
			number = 10,
			repeats = 3,
			returnResamp = "all")


#3 dataframe con solo los atributos. Este dataframe NO tiene la clase.
tmp <- subset(df.merge, select = 1:(ncol(df.merge) -1))

library("gbm")
library("survival")
library("splines")

#5 aplicando modelo al dataframe MODELO GBM
gbmFit <- train (tmp, 
		df.merge$class,
		method = "gbm",
		trControl= fitControl,
		verbose=TRUE)
#6 Resultados.
gbmFit$results

#7 Matriz de confusion.
confusionMatrix(gbmFit)

#8 añadiendo nueva data, leyendo corpus sin clase.
(cnewdata = Corpus(DirSource("./textos tm/input/"), readerControl = list(language="es")))

#9 dicionario
dfdicci= read.table("./textos tm/diccionarios/dic_total_uniq.txt")
mdicci = as.matrix(dfdicci)
vdicci = as.vector(mdicci)
dicci = Dictionary(vdicci)
rm(vdicci)
rm(mdicci)
rm(dfdicci)

#10 tratamiendo del corpus a convertir en dataframe con el diccionario de palabras.
dtmnewdata = DocumentTermMatrix(cnewdata, list(dictionary=dicci))
df.newdata <- as.data.frame(inspect(dtmnewdata))
rownames(df.newdata)<- 1:nrow(dtmnewdata)

#11 obteniendo prediccion
prediccion = predict(gbmFit, newdata=df.newdata)

summary(prediccion)
#12 armando dataframe
t <- cbind(df.newdata, prediccion)

#13 guardando resultado en un archivo externo
write.csv(t, './textos tm/output/resultado_final')

#14 obteniendo que archivo y que clase se encontraron
dfprediction <-cbind(inspect(dtmnewdata[,1]), prediccion)
write.csv(dfprediction, './textos tm/output/predicciongbmfit.txt')

#15 imprimiento 40 archivos y sus clases.
cat("quien es quien en la prediccion gbmfit\n")
head(prediccion)

#16 evaluando los casos pruebas.
densityplot(gbmFit, as.table=TRUE)

#17 modelo treebag MODELO TREEBAG
treefit <- train (tmp, df.merge$class,method = "treebag",trControl= fitControl,verbose=TRUE)

#18 Resultados.
treefit$results

#19 Matriz de confusion.
confusionMatrix(treefit)

#20 obteniendo prediccion
prediccion = predict(treefit, newdata=df.newdata)

summary(prediccion)
#21 armando dataframe
t2 <- cbind(df.newdata, prediccion)

#22 guardando resultado en un archivo externo
write.csv(t2, './textos tm/output/resultado_treefit')

#23 obteniendo que archivo y que clase se encontraron
dfpredictiontreefit <-cbind(inspect(dtmnewdata[,1]), prediccion)

#24 guardando predicciones
write.csv(dfpredictiontreefit, './textos tm/output/predicciontreebagfit.txt')

#25 imprimiento 40 archivos y sus clases.
cat("quien es quien en la prediccion treebagfit\n")
head(prediccion)

#26 evaluando los casos pruebas.
densityplot(treefit, as.table=TRUE)

#27 Modelo
#bagfit <- train(	tmp,
#	df.merge$class,
#	method="bagFDA",
#	trControl = fitControl,
#	tuneLength = 10)

#bagfit$results

#26 Matriz de confusion.
#confusionMatrix(bagfit)

#27 obteniendo prediccion
#prediccion = predict(bagfit, newdata=df.newdata)

#28 armando dataframe
#t3 <- cbind(df.newdata, prediccion)

#29 obteniendo que archivo y que clase se encontraron
#dfpredictionbagfit <-cbind(inspect(dtmnewdata[,1]), prediccion)
library("earth")
library("mda")
library("survival")
library("splines")
library(caTools)

#27 comparando modelos#30 modelo logitBoost
logitboostfit <- train (tmp, df.merge$class,method = "logitBoost",trControl= fitControl,tuneLength = 10)

#28 Resultados.
logitboostfit$results

#29 Matriz de confusion.
confusionMatrix(logitboostfit)

#30 obteniendo prediccion
prediccion = predict(logitboostfit, newdata=df.newdata)
summary(prediccion)
#31 armando dataframe
t3 <- cbind(df.newdata, prediccion)

#32 guardando resultado en un archivo externo
write.csv(t3, './textos tm/output/resultado_logitboostfit')

#33 obteniendo que archivo y que clase se encontraron
dfpredictionlogitboostfit <-cbind(inspect(dtmnewdata[,1]), prediccion)
write.csv(dfpredictionlogitboostfit, './textos tm/output/prediccionlogicboostfit.txt')

#34 imprimiento 40 archivos y sus clases.
cat("quien es quien en la prediccion logitboost FIT\n")
head(prediccion)

#35 evaluando los casos pruebas.
densityplot(logitboostfit, as.table=TRUE)
