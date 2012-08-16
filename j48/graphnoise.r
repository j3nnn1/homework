j <- c(0)
file <- 'graph_cortado_performance'
ext <- '.csv'
imagename <- 'graph_performance'
extimage <- '.png'

	graphics.off()  
	image <- paste(imagename, j, extimage, sep = "")
	filetraining = paste(file, ext, sep = "")
	
	treenoise = read.table(filetraining,",", header=T)
	png(image)
	plot(treenoise$trainpercentcorrect ~ treenoise$sizetree  ,type="o",col="green", xlim=range(treenoise$sizetree), ylim=range(0,100))
	lines(treenoise$testpercentcorrect ~ treenoise$sizetree , type="o", col="red", xlim=range(treenoise$sizetree), ylim=c(0, 100), lwd=1)
	titulo <- 'Performance'
	ftitulo <- paste(titulo, j)
	title(main = ftitulo)
	grid(10, lty=1,lwd=2, col="lightgray")
	dev.off()
	
	print(treenoise)
