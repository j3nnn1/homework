
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


