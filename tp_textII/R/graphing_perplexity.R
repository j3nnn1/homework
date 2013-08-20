
library("ggplot2")
data = read.table("all_models_perplexity.tsv", sep="\t", header=T)
doit <- function(x) {(x - min(x, na.rm=TRUE))/(max(x,na.rm=TRUE) - min(x, na.rm=TRUE))}
data$perplexity = doit(data$perplexity)
data$k = as.factor(data$k)
ggplot(data=data, aes(x=data$i, y=data$perplexity, group=k , colour=data$k)) + geom_line(aes(y=data$perplexity),size=1) + geom_point()

aes(y = var0, colour = "var0")


