
library("tm")
library("Snowball")

files = read.table("tostemming.txt", header=FALSE,sep="\n")
files = as.vector(t(files))
mystopwords = read.table("es3.2.txt", header=FALSE,sep="\n")
mystopwords = as.vector(t(mystopwords))
sizedocs = length(files)

for (i in 1:sizedocs) {
	(noticias = Corpus(DirSource(files[i]), readerControl = list(language="es")))
	noticias <- tm_map(noticias, tolower) 
	noticias <- tm_map(noticias, removePunctuation) 
	noticias = tm_map(noticias,removeWords,stopwords("spanish"))
	noticias = tm_map(noticias,removeWords,mystopwords)
	noticias = tm_map(noticias,stemDocument)
	size = length(noticias)
        mainDir = files[i]  
        subDir = paste0(files[i], '_stem')
        print( mainDir)
        print (subDir )
        if (file.exists(subDir)) {
          setwd(subDir)
        } else {
	  dir.create(subDir)
          setwd(subDir)
        }
	for (i in 1:size ) {
	filename = paste0(subDir,i)
	filename = paste0(filename,'.txt')
	write.table(noticias[[i]], file=filename, row.names=F, col.names=F)
	}
}
