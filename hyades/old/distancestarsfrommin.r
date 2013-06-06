#!/usr/bin/R
#when it's not my machine.
#dirout = './out'
#getwd()
#setwd('C:/somethingnull/git/tools/hyades/')
simbad = read.table('simbad.csv', header=T, sep=';')
hipparcos = read.table('HIPPARCOS.csv', header=T, sep=';')
cruzados = read.table('id_cruzados.csv', header=T, sep=',')
mdistances = dist(rbind(hipparcos[2:nrow(hipparcos),2:3], simbad[2:nrow(simbad),4:5]))
mallmerge = rbind(hipparcos[2:nrow(hipparcos),2:3], simbad[2:nrow(simbad),4:5])
#diit to matrix 
mdist =as.matrix(mdistances)

#matrix to vector
vecdist <- c(mdist)

#withoutzero####################
vecdist <- vecdist[vecdist>0]
################################

#format sci
format(minvecdist, sci = FALSE)

#classify stars, do a hist
allcruzados = rbind(as.matrix(cruzados[2:nrow(cruzados),3:4]), as.matrix(cruzados[2:nrow(cruzados),5:6]))

#dist cruzados
mdistcruz = dist(allcruzados)

#matrix to vector.
vecdistcruz = c(as.matrix(mdistcruz))

#deleting with out zerc
sincero = vecdistcruz[vecdistcruz>0]

#min distance to be hyades #########
mincruz = min(sincero)
####################################

#get distance value only for watch.
candidatehyadesmincruzados = vecdist[vecdist < as.numeric(mincruz)]

#compare distances with the min, this get the index where the value is lower than mincruz
vecdist2 = which(vecdist < as.numeric(mincruz))

#getting position from the distance's matrix

getindexs <- function (i, mdist) {
	return (which(mdist == vecdist[vectdist2[i]], arr.ind = TRUE))
}
star =  array(0,dim=c(0,2))
for (i in 1:length(vectdist2)) {
	tmp = getindexs(i, mdist)
	#print tmp
	star <- rbind(star, tmp)
}

#setting dataframe
newhyades <- data.frame(fila=NA, columna=NA, RA_J2001=NA, DE_J2001=NA,RA_J2000=NA, DE_J2000=NA )
newhyades$fila <- ''
newhyades$columna  <- ''
newhyades$RA_J2001  <- ''
newhyades$DE_J2001  <- ''
newhyades$RA_J2000  <- ''
newhyades$DE_J2000  <- ''

for (i in 1:nrow(star)) {
	print (star[i,1]) 
	print (star[i,2])
	newhyades[i,1] = star[i,1] 
	newhyades[i,2] = star[i,2] 
	newhyades[i,3:4] = mallmerge [star[i,1],]
	newhyades[i,5:6] = mallmerge [star[i,2],]
}
write.csv(newhyades, 'newcandidatetohyadesfrommin.csv')
