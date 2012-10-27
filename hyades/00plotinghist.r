#!/usr/bin/R

##dirout = './out'
simbadO = read.table('simbad.csv', header=T, sep=';')
hipparcosO = read.table('hipparcos.csv', header=T, sep=';')
cruzados = read.table('id_cruzados.csv', header=T, sep=',')

simbad = data.frame(ID=simbadO$identifier, RA_J2000=simbadO$RA_J2000, DE_J2000=simbadO$DE_J2000)
hipparcos = data.frame(ID=hipparcosO$HIP, RA_J2000=hipparcosO$RA_J2000, DE_J2000=hipparcosO$DE_J2000)

simbad = as.matrix(simbad)
hipparcos = as.matrix(hipparcos)

mdistances = dist(rbind(simbad[1:nrow(simbad),2:3], hipparcos[1:nrow(hipparcos), 2:3]))

#diit to matrix 
mdist =as.matrix(mdistances)

#matrix to vector
vecdist <- c(mdist)

#withoutzero
vecdist <- vecdist[vecdist>0]

#unclassify stars, do a hist
hdatadist = hist(vecdist);

#dist cruzados
allcruzados = rbind(as.matrix(cruzados[2:nrow(cruzados),3:4]), as.matrix(cruzados[2:nrow(cruzados),5:6]))


axis(1, max(allcruzados), paste("best",k.best,sep="\n"), col = "red", col.axis = "red")


#classify stars, do a hist
mdistcruz = dist(allcruzados)

#matrix to vector.
vecdistcruz = c(as.matrix(mdistcruz))

#oh god why
hdatacruz = hist(vecdistcruz, col="green", add=T)

#where cut
#hdatacruz$breaks

#deleting with out zerc
sincero = vecdistcruz[vecdistcruz>0]

#min distance to be hyades de 0 a 2
mincruz = min(sincero)

#plotting
h = hist(vecdist);
plot(h$counts, log="xy", pch=20, col="blue",
	main="Log-normal distribution",
	xlab="Value", ylab="Frequency")

hc = hist(sincero)
points(hc$counts, pch=20, col="green",
	main="Log-normal distribution",
	xlab="Value", ylab="Frequency")

#filtering distances






