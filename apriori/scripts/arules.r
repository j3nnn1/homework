#!/usr/bin/R
#
# params
# sop1 = support high
# sop2 = support low
# R CMD BATCH thisfile.r

library("arules")
library("arulesViz")

sop1 <- c(0.2)
sop2 <- c(0.3)
confidence <- c(0.9)

tr = read.transactions("~/datamining/apriori/data/transaccionesNOfrecuente.basket", sep=',', cols=c(1), format="basket")

image(tr)
summary(tr)

# frequency Plot
itemFrequencyPlot(tr, supp=sop1)
itemFrequencyPlot(tr, supp=sop2)

# apriori with high support
rules = apriori(tr, parameter= list(supp=sop1, conf=confidence))
inspect(rules)
par(cex=0.5)
plot(rules, method="graph", control=list(type="items"))
plot(rules, method="grouped")
saveAsGraph(rules, file="rulestransaction01.graphml")

# apriori with low support
rules = apriori(tr, parameter= list(supp=sop2, conf=confidence))
inspect(rules)
plot(rules, method="graph", control=list(type="items"))
plot(rules, method="grouped")
saveAsGraph(rules, file="rulestransaction02.graphml")
