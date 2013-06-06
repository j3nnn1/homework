#!R /usr/bin/R
#graficando resultados
join = read.table('identificacioncruzadasimbadhipparcos.csv', header=T, sep=',', quote='"', dec=',')
plot(c(join$RA_J2000, join$DE_J2000), pch='*', col='green')
title(main = 'Estrellas simbad cruzadas con hipparcos')
#points(join$RA_SIMBADJ2001, join$DE_SIMBADJ2001, col='blue', pch='O')
grid(col = "lightgray", lty = "dotted", equilogs = TRUE)
legend(5.5,15,c('* hipparcos'), col=c("green"), plot=TRUE, pch="-", lty=0)
