  library(stats)
  library(cluster)
  library(caret)
  library(tm)

#leyendo cada corpus
	(closk = Corpus(DirSource("./textos tm/train/k_train/"), readerControl = list(language="es")))
(closcorpo = Corpus(DirSource("./textos tm/train/corpo_train/"), readerControl = list(language="es")))
closk <- tm_map(closk,removeWords,stopwords("spanish"))
closcorpo <- tm_map(closcorpo,removeWords,stopwords("spanish"))

#uniendo cada corpus
merge <- c(closk, closcorpo)

#dtm
dtmk = DocumentTermMatrix(merge)

#remove sparse terms
myTdm2 <- removeSparseTerms(dtmmerge, sparse=0.95)
m2 <- as.matrix(myTdm2)
m3 <- t(m2)
set.seed(122)
k <- 2
kmeansResult <- kmeans(m3, k)
round(kmeansResult$centers, digits=3)



 for (i in 1:k) {
 cat(paste("cluster ", i, ": ", sep=""))
 s <- sort(kmeansResult$centers[i,], decreasing=T)
 cat(names(s)[1:3], "\n")
 print(merge[which(kmeansResult$cluster==i)])
 }



#cluster terms
distMatrix <- dist(scale(m2))
fit <- hclust(distMatrix, method="ward")
plot(fit)
#cut tree into 10 clusters
rect.hclust(fit, k=10)
(groups <- cutree(fit, k=4))

transpose the matrix to cluster documents (tweets)
> m3 <- t(m2)
> # set a fixed random seed
> set.seed(122)
> # k-means clustering of tweets
> k <- 8
> kmeansResult <- kmeans(m3, k)
> # cluster centers
> round(kmeansResult$centers, digits=3)

We can fit a CART-style tree model with the rpart library. First we remerge the attorney and
severity columns back with the newly formed document-term matrix and the fit a tree model using
recursive partitioning.
>m5 <- as.matrix(dtm3)
>file <- myTdm2$class

>output<- data.frame(m5,file)
>m5 <- rpart(class ~ ClusterGroup12) #fit tree using clusters as predictors
