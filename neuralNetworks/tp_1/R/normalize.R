clima = read.table('clima_numerico.csv', sep=',', header=T)
doit <- function(x) {(x - min(x, na.rm=TRUE))/(max(x,na.rm=TRUE) - min(x, na.rm=TRUE))}
clima$temperatura = doit(clima$temperatura)
clima$humedad = doit(clima$humedad)
clima$humedad = round(clima$humedad, 4)
clima$temperatura = round(clima$temperatura, 4)
write.csv(clima, '/media/misperoles/git/homework/neuralNetworks/tp_1/clima_numerico_normalize.csv')

adult = read.table('Adult_Parte1.csv', sep=',', header=T)

adult$edad = doit(adult$edad)
adult$educacion = doit(adult$educacion)
adult$horas_semana = doit(adult$horas_semana)

adult$edad = round(adult$edad, 4)
adult$educacion = round(adult$educacion, 4)
adult$horas_semana = round(adult$horas_semana, 4)
write.csv(adult, '/media/misperoles/git/homework/neuralNetworks/tp_1/adult_parte1_normalize.csv')
