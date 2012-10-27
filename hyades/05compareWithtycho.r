
tycho = read.table('tycho.csv', sep='\t', header=T, quote='"', dec=',')
simbad = read.table('simbad.csv', sep=';', header=T)
crossover = read.table('id_cruzadoswithdistance.csv', sep=',', header=T)

#cut columns
a = as.matrix(cbind(simbad$RA_J2000, simbad$DE_J2000), nrow=nrow(simbad), byrow=T)
b = as.matrix(cbind(tycho[,6:7]), nrow=nrow(tycho), byrow=T, ncol=2)

#putting rownames
rownames(a) <- simbadO$identifier
rownames(b) <- tycho$N


min.dist <- array()
min.dist.name <- array()
dists.ab <- array()

for (i in 1:nrow(a)){ #simbad
    for (j in 1:nrow(b)) { #tycho
        dists.ab[j] <- dist(rbind(a[i,],b[j,])) #almaceno las distancias
    }
    min.dist.name[i] <- which.min(dists.ab)
    min.dist[i] <- min(dists.ab)
}


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
maxjoindist = max(cruzados$distancia)
maxjoindist=as.numeric(maxjoindist)

candidate.name = cbind(min.dist.name, min.dist < maxjoindist)
#get index
candidate.name = cbind(candidate.name, row(candidate.name))
candidate.name <- candidate.name[,1:3]
candidate.name.df = subset(candidate.name, candidate.name[,2]==1)
candidate.name.df = data.frame(candidate.name.df)
colnames(candidate.name) = c('ID_tycho','candidato', 'id_simbad')

tychof = tycho[,c(1,6,7,8,9,10,11,12,13,14,15)]
tychof = cbind(tychof, indexcandidate=1:length(dists.ab))

dfmergeall = merge (candidate.name.df, tychof, by.x='ID_tycho', by.y='indexcandidate') 

write.csv(dfmergeall, 'identificacioncruzadasimbadtycho.csv')


