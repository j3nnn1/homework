
library("ggplot2")
perplexity = read.table("all_models_perplexity.tsv", sep="\t", header=T);
perplexity$tag = paste0(perplexity$k,perplexity$i)
perplexity$tag = as.factor(perplexity$tag)
data = perplexity[,3:4]
ggplot(data=data, aes(x=data$tag, y=data$perplexity, group=tag , colour=data$tag)) + geom_line(aes(y=data$perplexity),size=1) + geom_point()

