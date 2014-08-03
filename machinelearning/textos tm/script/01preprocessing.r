library("tm")


#1 leyendo diccionario de palabras filtradas por hernan
dfdicci= read.table("./textos tm/diccionarios/dic_total_uniq.txt")
mdicci = as.matrix(dfdicci)
vdicci = as.vector(mdicci)
dicci = Dictionary(vdicci)

#2 leyendo cada corpus.
# corpus with 692 text documents
(closk = Corpus(DirSource("./textos tm/train/k_train/"), readerControl = list(language="es")))
#A corpus with 541 text documents
(closcorpo = Corpus(DirSource("./textos tm/train/corpo_train/"), readerControl = list(language="es")))

#3 eliminando stopwords en español
closk <- tm_map(closk,removeWords,stopwords("spanish"))
closcorpo <- tm_map(closcorpo,removeWords,stopwords("spanish"))

#4 merge de los corpus
merge <- c(closk, closcorpo)

#5 creando dtm con diccionario filtrado por hernan
dtmmerge = DocumentTermMatrix(merge, list(dictionary=dicci))

#6 convirtiendo en data frame
df.merge<- as.data.frame(inspect(dtmmerge))
rownames(df.merge)<- 1:nrow(dtmmerge)

#7 generando columna clase de acuerdo al orden en 4
class <- c(rep("k",702),rep("corpo",551))
#class <- c(rep("k",692),rep("corpo",541))
ncol(df.merge)

#8 añadiendo clase
df.merge<- cbind(df.merge,class)
rm(class)
rm(dtmmerge)
rm(merge)
rm(closcorpo)
rm(closk)
#9 verificando atributos que tienen varianza cercana a 0
library("caret")
cerovalores = nearZeroVar(df.merge, freqCut = 95/5, uniqueCut = 10, saveMetrics = TRUE)

#10 Devuelve los indices de las columnas que tienen varianza cercana a 0
cerovaloresquitar = nearZeroVar(df.merge)

#11 obtengo las columnas que tienen varianza cercana a 0, solo para observar que atributos son. 
quitar = cerovalores[cerovalores$nzv==TRUE,]
#nrow(quitar)
#nrow(cerovalores)

#12 diccionario nuevo contiene un dataframe sin los atributos que tienen varianza cercana a 0
diccionarionuevo = df.merge[, -c(cerovaloresquitar)]

#13 guardar data frame final que sera evaluado por 3 metodos.
write.csv(diccionarionuevo, './textos tm/output/dataclase.csv')
