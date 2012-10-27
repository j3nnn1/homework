
simbadO = read.table('simbad.csv', header=T, sep=';')
hipparcosO = read.table('HIPPARCOS.csv', header=T, sep=';')
#cut columns
simbad = data.frame(Id= simbadO$identifier,RA_J2000 = simbadO$RA_J2000, DE_J2000=simbadO$DE_J2000)
hipparcos = data.frame(ID_HIP = hipparcosO$HIP, RA_J2000=hipparcosO$RA_J2000, DE_J2000=hipparcosO$DE_J2000)

vidsimbad = c()
vdistancemin = c()
vidhipparmin = c()
vcoordhipp = c()
vectdisthip = c()

for (i in 1:nrow(simbad)){

   
    for (j in 1:nrow(hipparcos)) {
    
        tmp = rbind(c(simbad[i,]$RA_J2000,simbad[i,]$DE_J2000), c(hipparcos[j,]$RA_J2000,hipparcos[j,]$DE_J2000))
        
        #coordenadas y distancias tendrán el mismo indice perfecto
        
        vectdisthip <- rbind(vectdisthip, dist(tmp)) #almaceno las distancias
        
        vcoordhipp <- rbind(vcoordhipp, hipparcos[j,]$ID_HIP)  #almaceno las coordenadas hipparcos
	
	vidsimbad <- rbind(vidsimbad, simbad[i,]$Id) #ids simbad
        
    }
}

nrow(vidhipparmin)
nrow(simbad)
nrow(vdistancemin)
nrow(vidsimbad)

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

#join ids
outbind =  cbind(vcoordhipp, vidsimbad, vectdisthip)
colnames(outbind) <- c('ID_HIP', 'ID_SIMBAD', 'DISTANCE')


#comparing min hipparcos with max cruzados getting the index
vindexdis = which(outbind[,'DISTANCE'] < as.numeric(maxjoindist))

dfhip = outbind[vindexdis,]

#creating df with merge with hipp and simbad
#merge
hipparcosO  = read.table('hipparcosoriginal.csv' header=T, sep=';')
hipparcosO = hipparcosO[,1:8]
dfmergeall = merge(dfhip, hipparcosO, by.x='ID_HIP', by.y='HIP')

#saving
write.csv(dfmergeall, 'identificacioncruzadasimbadhipparcos.csv')


