getwd()
setwd('C:/somethingnull/git/tools/hyades/');
tycho = read.table('tycho.csv', sep='\t', header=T)
simbad = read.table('simbad.csv', sep=';', header=T)
crossover = read.table('id_cruzadoswithdistance.csv', sep=',', header=T)

#formated. this only I did once.
#tycho = tycho[,1:14] 
#write.csv(tycho, 'tycho.csv')

#Getting as_R and DE from simbad and tycho.
points = rbind(as.matrix(tycho[,5:6]), as.matrix(simbad[,c(6,8)]))

#getting matrix distance between alls. at this line required over 2GB en memory RAM :( I don't have
mdistances = as.matrix(dist(points))

#deleting the diag, and lower 
mdist[lower.tri(mdist, diag=TRUE)] <- NA

#matrix to vector
vecdist <- c(mdist)

#delete index with NA
vecdist <- vecdist[!is.na(vecdist)]

#getting  crossover
outbind = merge (tycho, crossover, by.x='HIP' , by.y='ID.HIP')
write.csv(outbind, 'id_cruzadoswithdistancewithtycho.csv')

#getting the threshold distance
maxdist = max(outbind$distancia)

#getting all candidate of tycho.
vecdist2 = which(vecdist < as.numeric(maxdist))


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

	
newhyades <- data.frame(fila=NA, columna=NA, RA_J2001=NA, DE_J2001=NA,RA_J2000=NA, DE_J2000=NA )
newhyades$fila <- 0
newhyades$columna  <-0
newhyades$RA_J2001  <- 0
newhyades$DE_J2001  <- 0
newhyades$RA_J2000  <- 0
newhyades$DE_J2000  <- 0

tam = nrow(star)
mallmerge = rbind(tycho[1:nrow(tycho),5:6], simbad[1:nrow(simbad),c(6,8)])

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
write.csv(newhyades, 'newcandidatetohyadeswithtycho.csv')

