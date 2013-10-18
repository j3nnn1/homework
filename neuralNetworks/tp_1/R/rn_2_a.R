
library('ggplot2')
library('MASS')

#rn = read.table('../data/RN_adult_parte_no_escala1_a.csv', sep=',', header=T)
rn = read.table('../data/RN_adult1_class_intercalate1_c.txt', sep=',', header=T)
#%rn = read.table('../data/RN_adult_parte_normalize1_b.csv', sep=',', header=T)


#n(subset(rn, alfa==alit & Ite < Max_It)$Ite, na.rm=FALSE)For each alfa average Accuraccy
mean(subset(rn, alfa==-0.5)$Aciertos)

#For each alfa average Ite
alit = -0.5
msg = c('')
Iten = c('')

while (alit < 0.6) {
	valid = nrow(subset(rn, alfa==alit & Ite < Max_It))
	#valid = nrow(subset(rn, alfa==alit))
        #print(alit)
	if (valid > 0 ){
            alfa = unique(subset(rn, alfa==alit & Ite < Max_It)$alfa)
            #alfa = unique(subset(rn, alfa==alit)$alfa)
	    Ite = mean(subset(rn, alfa==alit & Ite < Max_It)$Ite, na.rm=FALSE)
	    #Ite = mean(subset(rn, alfa==alit)$Ite, na.rm=FALSE)
	    successes = mean(subset(rn, alfa==alit & Ite < Max_It)$Aciertos, na.rm=FALSE)
	    #successes = mean(subset(rn, alfa==alit)$Aciertos, na.rm=FALSE)

            msg = paste('alfa:', alfa)
            msgIte = paste(' Ite < Max_It: ', valid)
            msgIt = paste(' Ite ', Iten)
            msgAvg = paste('AVG Ite: ', Ite)
            msgSuc = paste('AVG Successes: ', successes)

            msg = paste(msg, msgIte)
            msg = paste(msg, msgAvg)
            msg = paste(msg, msgSuc)
	    print (msg)
	}
	alit = alit + 0.1
}

#For each

