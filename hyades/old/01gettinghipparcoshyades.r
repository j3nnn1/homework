#!/usr/bin/R
#getwd()
#setwd('C:/somethingnull/git/tools/hyades/')
simbadO = read.table('simbad.csv', header=T, sep=';')
hipparcosO = read.table('HIPPARCOS.csv', header=T, sep=';')

#cut columns
simbad = data.frame(Id= simbadO$identifier,RA_J2000 = simbadO$RA_J2000, DE_J2000=simbadO$DE_J2000)
hipparcos = data.frame(ID_HIP = hipparcosO$HIP, RA_J2000=hipparcosO$RA_J2000, DE_J2000=hipparcosO$DE_J2000)

simbad = as.matrix(simbad) 	
hipparcos = as.matrix(hipparcos)

cruzados = read.table('id_cruzados.csv', header=T, sep=',')
mdistances = dist(rbind(hipparcos[1:nrow(hipparcos),2:3], simbad[1:nrow(simbad),2:3]))
#if is R 2.15 this
#mdistances = dist(rbind(hipparcos[1:nrow(hipparcos),2:3], simbad[1:nrow(simbad),2:3]), upper=FALSE, diag=FALSE)


#dist to matrix 
mdist =as.matrix(mdistances)

#delete lower
mdist[lower.tri(mdist, diag=TRUE)] <- NA

#matrix to vector
vecdist <- c(mdist)

#delete index with NA
vecdist <- vecdist[!is.na(vecdist)]


############################################################
# giselle's theorem :P
#filtering distances with the second min. other process.
#get the min distance between the join HIP and simbad.
############################################################

row.names(cruzados) <- NULL
mcruzados = as.matrix(cruzados)
for (i in 1:nrow(mcruzados)) {

	#create a mini matrix with one row.
	mnewmini = rbind(mcruzados[i,3:4], mcruzados[i,5:6])

	#matriz distance	
	disti =  dist(mnewmini)

	##adding distance to dataframe.
	#format sci
	cruzados$distancia[i] =	format(disti , sci = FALSE)
	
	#printdataframe
	cruzados$distancia[i]
}

#save distances in a new column.
write.csv(cruzados, 'id_cruzadoswithdistance.csv')

#maximum known distance between hipparcos y simbad 
maxjoindist = max(cruzados$distancia)

#compare distances with the max, this get the index where the value is lower than maxjoindist
vecdist2 = which(vecdist > 0)
vecdist2 = which(vecdist < as.numeric(maxjoindist))
#print (vecdist[vecdist2])

#getting index from mdistances
getindexs <- function (i, mdist) {
	return (which(mdist == vecdist[vecdist2[i]], arr.ind = TRUE))
}
star =  array(0,dim=c(0,2))
tam = length(vecdist2)

for (i in 1:length(vecdist2)) {
	tmp = getindexs(i, mdist)
	print (i)
	cat ('/')
	print (tam)
	star <- rbind(star, tmp)
}

#star contain the index of stars more closed to be hyades. 
#getting the registers.

mallmerge = rbind(hipparcos[1:nrow(hipparcos),2:3], simbad[1:nrow(simbad),2:3])

newhyades <- data.frame(fila=NA, columna=NA, RA_J2001=NA, DE_J2001=NA,RA_J2000=NA, DE_J2000=NA )
newhyades$fila <- 0
newhyades$columna  <-0
newhyades$RA_J2001  <- 0
newhyades$DE_J2001  <- 0
newhyades$RA_J2000  <- 0
newhyades$DE_J2000  <- 0

tam = nrow(star)

for (i in 1:nrow(star)) {
	#print (star[i,1]) 
	#print (star[i,2])
	print (i)
	cat('/')
	print (tam)
	newhyades[i,1] = star[i,1] 
	newhyades[i,2] = star[i,2] 
	newhyades[i,3:4] = mallmerge [star[i,1],]
	newhyades[i,5:6] = mallmerge [star[i,2],]
}
write.csv(newhyades, 'newcandidatetohyades.csv')

##end giselle's theorem
####################################################################

#next do a pam
