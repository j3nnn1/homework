
simbadO = read.table('simbad.csv', header=T, sep=';')
hipparcosO = read.table('HIPPARCOS.csv', header=T, sep=';')

#cut columns
a = as.matrix(cbind(simbadO$RA_J2000, simbadO$DE_J2000), nrow=nrow(simbadO), byrow=T)
b = as.matrix(cbind(hipparcosO$RA_J2000, hipparcosO$DE_J2000), nrow=nrow(hipparcosO), byrow=T)

#putting rownames
rownames(a) <- simbadO$identifier
rownames(b) <- hipparcosO$HIP

min.dist <- array()
min.dist.name <- array()
dists.ab <- array()

for (i in 1:nrow(a)){ #simbad
    for (j in 1:nrow(b)) { #hipparcos
        dists.ab[j] <- dist(rbind(a[i,],b[j,])) #almaceno las distancias
    }
    min.dist.name[i] <- which.min(dists.ab)
    min.dist[i] <- min(dists.ab)
}

nrow(dists.ab)
length(dists.ab)
length(min.dist)

#this is the value to look
head(min.dist)
########################

#getting the limit
cruzados = read.table('id_cruzados.csv', header=T, sep=',')
mcruzados = as.matrix(cruzados)

for (i in 1:nrow(mcruzados)) {

        #create a mini matrix with one row.
        mnewmini = rbind(mcruzados[i,3:4], mcruzados[i,5:6])

        #matriz distance        
        disti =  dist(mnewmini)

        ##adding distance to dataframe.
        #format sci
        cruzados$distancia[i] = format(disti , sci = FALSE)

        #printdataframe
        cruzados$distancia[i]
}
maxjoindist=as.numeric(maxjoindist)
maxjoindist = max(cruzados$distancia)

#getting joins
#min.dist.name
maxjoindist=as.numeric(maxjoindist)
#candidate = min.dist [ min.dist < maxjoindist]
candidate.name = cbind(min.dist.name, min.dist < maxjoindist)
rownames(candidate.name) = simbadO$Identifier

#get index
candidate.name = cbind(candidate.name, row(candidate.name))
candidate.name <- candidate.name[,1:3]
colnames(candidate.name) = c('ID_HIP','candidato', 'id_simbad')

candidate.name.df = subset(candidate.name, candidate.name[,2]==1)
candidate.name.df = data.frame(candidate.name.df)

#creating df with merge with hipp and simbad
hipparcosO  = read.table('hipparcos.csv', header=T, sep=',')
hipparcosO = hipparcosO[,1:8]

#add to b the index row
hipparcosO = cbind(hipparcosO, indexcandidate= 1:length(dists.ab))


dfmergeall = merge(candidate.name.df, hipparcosO, by.x='ID_HIP', by.y='indexcandidate')

#saving
write.csv(dfmergeall, 'identificacioncruzadasimbadhipparcos.csv')
write.csv(candidate.name, 'hipparcoshyades.csv')
