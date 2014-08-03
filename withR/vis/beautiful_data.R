
url='http://samarium.wikimedia.org/campaign-vs-amount.csv';
wiki = read.delim(url,sep=",");
plot(wiki);
head(wiki);
hist(wiki$usdmax)
#select sub rows with usdmax less than 6000
index = which(wiki$usdmax < 6000)
wikiless = wiki[index,]

#select sub rows with usdmax less than 3000
index = which(wiki$usdmax < 800)
wikiless = wiki[index,]
hist(wikiless$usdmax)

#plot
plot(wiki$usdmax, wiki$avg, col=wiki$campaign)
plot(wiki$sum, wiki$avg)

plot(wiki$usdmax, wiki$medium, col=wiki$medium)
plot(wiki$avg, wiki$medium, col=wiki$medium) 
summary(wiki$medium)

library(ggplot2);
qplot(wiki$sum, wiki$medium)
qplot(wiki$avg, wiki$medium, col=wiki$medium);
qplot(wiki$usdmax, wiki$medium, col=wiki$medium);

smoothScatter(log(wiki$count), log(wiki$avg))
smoothScatter(log(wiki$count), log(wiki$avg), colramp=colorRampPalette(c('white', 'blue')))
smoothScatter(log(wiki$count), log(wiki$usdmax), colramp=colorRampPalette(c('white', 'deeppink')))


wiki$stop_date = as.numeric(wiki$stop_date)
wiki$start_date = as.numeric(wiki$start_date)
wikinumeric = wiki[,-c(1,2)]
cors = cor(wikinumeric, use='pair')

require(lattice)
levelplot(cors)
image(cors, col=col.corrgram(7)) # rainbow, heat.colors, topo.colors, terrain.colors 
image(cors, col = heat.colors(7))
axis(1, at=seq(0,1, length=nrow(cors)), labels=row.names(cors))

