
library("igraph");
edges   = read.table('sample.txt.out', sep=',', header=F);
net = graph.data.frame(edges, directed=FALSE, vertices=NULL);
E(net)$weight = edges$V3
write.graph(net, 'grafo_gephi.gml', "gml");
