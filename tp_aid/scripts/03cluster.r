# http://www.mattpeeples.net/kmeans.html
#con los componentes principales hacer los cluster
library("cluster")

cluskmeans <- list()
wss <- c();

for (k in 2:20) {
	cluskmeans[[k]]<- kmeans(winewhite.acp$x[,1:7], centers=k, k, nstart=10);
	wss[k] <- sum(kmeans(winewhite.acp$x[,1:7], centers=k, k, nstart=10)$withinss);
	print (k)
}
k.best <- which.min(wss);
plot(1:20, asw, type= "h", main = "pam() clustering assessment",
     xlab= "k (# clusters)", ylab = "average silhouette width")
axis(1, k.best, paste("best",k.best,sep="\n"), col = "red", col.axis = "red")


xrange <- range(1:20)
yrange <- range(log(wss))
plot(xrange,yrange, type='n', xlab='Conglomerados ', ylab='Log de la suma de cuadrados entre', main='Solución Conglomerados vs Log de SSE')
for (i in 1:250) {
lines(log(wss), type="b", col='blue')
}

yrange <- range(wss)
plot(xrange,yrange, type='n', xlab="Conglomerados", ylab="Distancia dentro de los grupos SSE", main="Solución Conglomerado vs SSE")
for (i in 1:20) {
lines(1:20, wss, type="b", col='blue')
}

#graficar el mejor numero de clusters
cluskmeans[8]


plot(winewhite.acp$x[,1:2], col=cluskmeans[[8]]$cluster, pch="+")
plot(winewhite.acp$x[,3:4], col=cluskmeans[[8]]$cluster, pch="+")
plot(winewhite.acp$x[,5:6], col=cluskmeans[[8]]$cluster, pch="+")
plot(winewhite.acp$x[,6:7], col=cluskmeans[[8]]$cluster, pch="+")


newwinewhite = data.frame(winewhite.acp$x[,1:7])
newwinewhite$clase = winewhite$quality
write.csv(newwinewhite, './data/newcompwine.csv')

