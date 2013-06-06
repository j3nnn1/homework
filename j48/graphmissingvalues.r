file <- '/somethingnull/r/missingvalues/arbolconfidence-ruido'
ext <- '.csv'
imagename <- '/somethingnull/r/missingvalues/arbolmissing'
extimage <- '.png'
j <- c(0.025)
while (j <= 0.90) {
	graphics.off()
	image <- paste0(imagename, j, extimage) 
	filetraining = paste0(file, j , ext)
	treenoise = read.table(filetraining,",", header=T)
	png(image)
	plot(treenoise$trainpercentcorrect ~ treenoise$sizetree  ,type="o",col="green", xlim=range(treenoise$sizetree), ylim=range(0,100))
	lines(treenoise$testpercentcorrect ~ treenoise$sizetree , type="o", col="red", xlim=range(treenoise$sizetree), ylim=c(0, 100), lwd=1)
	titulo <- 'Performance con Ruido'
	ftitulo <- paste(titulo, j)
	title(main = ftitulo)
	grid(10, lty=1,lwd=2, col="lightgray")
	dev.off()
	print(treenoise)
	j <- j + 0.025
}
