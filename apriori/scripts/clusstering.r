#!/usr/bin/R

#install.packages("cluster")
library(cluster)

#put here the column to discretize
#quantity in my case
column = c(13);
namecolumn = 'cant';
newcolumn = 'cantdis';

#reading file
dataframe = read.csv("/home/j3nnn1/apriori/tp_datamining/data/transacciones_v5_ext1.csv", sep=";", header=T)

#convert to matrix the column to discretize
mcant = as.matrix(dataframe[column])

#put a name
colnames(mcant) = namecolumn

#execute kmeans
(cl <- kmeans(mcant, 3, nstart=1))

#do a plot
png("~/datamining/apriori/graphs/transaccionescant.csv.png")
plot(mcant, col=cl$cluster, pch="+")
points(cl$centers,col = 1:3, pch=8, cex=5)
grid(col = "lightgray", lty = "dotted", equilogs = TRUE)
legend(100000,400,c('200 - inf','30 - 160',' 0-29'), col=c("green", "black", "red"), plot=TRUE, pch="-", lty=0)
abline(h=0, v=0, untf = FALSE, lty = "dotted")
dev.off()
#end of plot

#binding real value with the group
outbind = cbind(mcant, clusterNum = cl$cluster)

#add it to the dataframe
dataframe[newcolumn] = outbind[,2]

#output file
write.csv(dataframe, "~/datamining/apriori/output/transaccionescant.csv")
