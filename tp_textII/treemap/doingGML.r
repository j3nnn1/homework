
library("igraph");
edges   = read.table('iteracion5/noticias_word-topic-counts.6.5.txt.edgeslist', sep=',', header=F);
net = graph.data.frame(edges, directed=FALSE, vertices=NULL);
E(net)$weight = edges$V3
write.graph(net, 'noticias_composition.6.5.txt.gml', "gml");
