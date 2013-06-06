library("rgl")
library("ggplot2")
setwd('/media/misperoles/git/homework/tp_aid')
winewhite = read.table('./data/winewithoutliers.csv', sep=',', header=T)

winewhite.acp = prcomp(winewhite[,2:12], scale=T, cor=TRUE)

#Proportion of Variance 0.2817 0.1751 0.1410 0.1103 0.08721
summary(winewhite.acp)

#acp
plot(winewhite.acp, type='l')

#biplot
biplot(winewhite.acp, choices=2:3, scale=1, pc.biplot=FALSE, pch='.', type="lines")

#scatterplot
ggplot(winewhite, aes(fixed.acidity, volatile.acidity)) + geom_point(colour="blue", alpha=I(0.2))

#saving components with 80% variability
df.acp = winewhite.acp$x[,1:7] 
df.acp = as.data.frame(df.acp)
df.acp$clase = winewhite$quality
write.csv(df.acp, './data/acpwith7.csv')

PCbiplot <- function(PC, x="PC1", y="PC2") {
    # PC being a prcomp object
    data <- data.frame(obsnames=row.names(PC$x), PC$x)
    plot <- ggplot(data, aes_string(x=x, y=y)) + geom_text(alpha=.4, size=3, aes(label=obsnames))
    plot <- plot + geom_hline(aes(0), size=.2) + geom_vline(aes(0), size=.2)
    datapc <- data.frame(varnames=rownames(PC$rotation), PC$rotation)
    mult <- min(
        (max(data[,y]) - min(data[,y])/(max(datapc[,y])-min(datapc[,y]))),
        (max(data[,x]) - min(data[,x])/(max(datapc[,x])-min(datapc[,x])))
        )
    datapc <- transform(datapc,
            v1 = .7 * mult * (get(x)),
            v2 = .7 * mult * (get(y))
            )
    plot <- plot + coord_equal() + geom_text(data=datapc, aes(x=v1, y=v2, label=varnames), size = 5, vjust=1, color="red")
    plot <- plot + geom_segment(data=datapc, aes(x=0, y=0, xend=v1, yend=v2), alpha=0.75, color="red")
    plot
}

row.names(winewhite.acp$x) <- row.names(winewhite.acp);
PCbiplot(winewhite.acp)
