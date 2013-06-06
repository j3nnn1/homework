library('cluster')
#getwd()
#setwd('C:/somethingnull/git/tools/hyades/')
#simbad = read.table('simbad.csv', header=T, sep=';')

hipparcos = read.table('hipparcoshyades.csv', header=T, sep=',')
cruzados = read.table('id_cruzados.csv', header=T, sep=',')
join = read.table('newcandidatetohyades2.csv', header=T, sep=',')

mallmerge = data.frame(RA=hipparcos$RA_J2000,DE=hipparcos$DE_J2000, PLX=hipparcos$Plx, PMRA=hipparcos$pmRA, PMDE=hipparcos$pmDE, VMAG=hipparcos$Vmag, BV=hipparcos$BV, HYADES=hipparcos$hyades)

asw <- numeric(20)
cluspam <- list()

for (k in 2:20) {
	 cluspam[[k]] <- pam(mallmerge[,-8], k) 
	 asw[k] <- cluspam[[k]]$silinfo$avg.width 
	 print (k)
}

k.best <- which.max(asw)
cat("silhouette-optimal number of clusters:", k.best, "\n")
plot(1:20, asw, type= "h", main = "pam() clustering assessment",
     xlab= "k  (# clusters)", ylab = "average silhouette width")
axis(1, k.best, paste("best",k.best,sep="\n"), col = "red", col.axis = "red")

########## doing pam with k.best

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

#testin witouht PLX
dta <- hipparcos[c(2,3,5,6,7, 8)] # get data
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
dta.o <- order.single(dta.r)
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5, pch='.',
main="Variables Ordenadas y Coloreadas por la correlación" ) 

#testing withput pmRA pmDE

dta <- hipparcos[c(2,3,4,7, 8)] # get data
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
dta.o <- order.single(dta.r)
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5, pch='.',
main="Variables Ordenadas y Coloreadas por la correlación" ) 


#final
dta <- hipparcos[c(2,3,4,7)] # get data
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
dta.o <- order.single(dta.r)
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5, pch='.',
main="Variables Ordenadas y Coloreadas por la correlación" ) 

library(scatterplot3d)
scatterplot3d(dta[1:3], main="3D Scatterplot", highlight.3d=TRUE, type="h", pch='*')

#getting candidate

join = subset(hipparcos, hyades==1)
plot(hipparcos[c(7, 8)], col=cluspam[[2]]$cluster, pch="+")
points(cluspam[[2]]$medoids[,6:7],col = 1:2, pch=19, cex=3)
points(join[, 7:8], col='blue', pch='x', cex=1)
grid(col = "lightgray", lty = "dotted", equilogs = TRUE)
abline(h=0, v=0, untf = FALSE, lty = "dotted")
legend(0,2.5,c(1:2), col=c('black', 'red'), plot=TRUE, pch="-", lty=0)

#adding new nding real value with the group
outbind = cbind(hipparcos, clusterNum = cluspam[[3]]$clustering)
outbind = subset(outbind, clusterNum==2)


#saving dataset
write.csv(outbind, 'candidatehyadespam.csv')


