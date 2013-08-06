setwd('C:/somethingnull/git/tools/tp_aid/')
wine = read.table('winequalitywhite.csv', sep=';', header=T)
plot(wine, pch='.', col='blue')
