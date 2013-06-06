library('cluster')

hipparcos = read.table('hipparcoshyades.csv', header=T, sep=';')
cruzados = read.table('id_cruzados.csv', header=T, sep=',')
asw <- numeric(20)
cluspam <- list()

mallmerge = data.frame(PLX=hipparcos$Plx, PMRA=hipparcos$pmRA, PMDE=hipparcos$pmDE, VMAG=hipparcos$Vmag, BV=hipparcos$BV, HYADES=hipparcos$hyades)

for (k in 2:20) {
	 cluspam[[k]] <- pam(mallmerge[,-8], k, stand = TRUE) 
	 asw[k] <- cluspam[[k]]$silinfo$avg.width 
	 print (k)
}
k.best <- which.max(asw)
cat("silhouette-optimal number of clusters:", k.best, "\n")
plot(1:20, asw, type= "h", main = "pam() clustering assessment",
     xlab= "k  (# clusters)", ylab = "average silhouette width")
axis(1, k.best, paste("best",k.best,sep="\n"), col = "red", col.axis = "red")
name = 'cluster'
ext = '.png'
for (k in 2:20) {
	title = paste0(name, k)
	title = paste0(title, ext)
	png(title)
	plot(mallmerge, col=cluspam[[k]]$clustering, pch="+")
	points(cluspam[[k]]$medoids,col = 1:k, pch=8, cex=5)
	grid(col = "lightgray", lty = "dotted", equilogs = TRUE)
	abline(h=0, v=0, untf = FALSE, lty = "dotted")
	dev.off()
}

### scatter plot matrix
pairs(~RA+DE+PLX+PMRA+PMDE+VMAG+BV+HYADES,data=mallmerge,
   main="Matriz de Gráficos de Dispersión")


library(gclus)
dta <- hipparcos[c(2,3,4,5,6,7,8)] # get data
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
# reorder variables so those with highest correlation
# are closest to the diagonal
dta.o <- order.single(dta.r)
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5, pch='.',
main="Variables Ordenadas y Coloreadas por la correlación" )


#this is a scatter plot
plot(hipparcos, pch='.')
grid(col = "lightgray", lty = "dotted", equilogs = TRUE)

#getting sse for k=2 and k=3
SSE <- function(x,c,cl) { sum((c[cl,]-x)^2) }

sse = array()

for (k in 2:20) {
sse[k] = SSE(mallmerge[,-8], cluspam[[k]]$medoids, cluspam[[k]]$clustering)
}

#plotting sse vs k
plot (1:20,sse, pch='*', xlab='k', ylab='sse', type= "h")




#scatter plot matrix with cluster
outbind = cbind(hipparcos, clusterNum = cluspam[[2]]$clustering)
plot(outbind[,-10], col=outbind$clusterNum, pch='.')
outbind = subset(outbind, clusterNum==2)


#cluster 5
outbind5 = cbind(hipparcos, clusterNum = cluspam[[5]]$clustering)
plot(outbind[,-10], col=outbind$clusterNum, pch='.')
outbind = subset(outbind, clusterNum==2)




#getting candidate
join = subset(hipparcos, hyades==1)
plot(hipparcos[c(7, 8)], col=cluspam[[2]]$cluster, pch="+")
points(cluspam[[2]]$medoids[,6:7],col = 1:5, pch=19, cex=3)
points(join[, 7:8], col='blue', pch='x', cex=1)
grid(col = "lightgray", lty = "dotted", equilogs = TRUE)
abline(h=0, v=0, untf = FALSE, lty = "dotted")
legend(0,2.5,c(1:2), col=c('black', 'red'), plot=TRUE, pch="-", lty=0)

#another cluster
join = subset(hipparcos, hyades==1)
plot(hipparcos[c(5, 6)], col=cluspam[[2]]$cluster, pch="+")
points(cluspam[[2]]$medoids[,4:5],col = 1:5, pch=19, cex=3)
points(join[, 5:6], col='blue', pch='x', cex=1)
grid(col = "lightgray", lty = "dotted", equilogs = TRUE)
abline(h=0, v=0, untf = FALSE, lty = "dotted")
legend(0,2.5,c(1:2), col=c('black', 'red'), plot=TRUE, pch="-", lty=0)


#creando tabla que contiene en que cluster se distribuyen las hyades.
clust1candidate = subset(outbind, clusterNum==1 & hyades==1)
clust2candidate = subset(outbind, clusterNum==2 & hyades==1)
nrow(outbind[outbind$clusterNum==1,])
nrow(outbind[outbind$clusterNum==2,])

candidatematrix = matrix(c(1, nrow(clust1candidate), nrow(outbind[outbind$clusterNum==1,]),
			   2, nrow(clust2candidate), nrow(outbind[outbind$clusterNum==2,])), byrow=TRUE, nrow=2, ncol=3) 


#guardando las estrellas del cluster de 403, cluster 2.

final = outbind[outbind$clusterNum==2,]
write.csv (final, 'starshyadescandidatepart1.csv')

