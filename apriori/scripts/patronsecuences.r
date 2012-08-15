#!/usr/bin/R

#Limpieza antes..
#1,$s/}//g
#1,$s/{//g
#1,$s/"//g
#1,$s/^"\d*",//g
# patern secuences get as input a file with a eventID ordered. 
# because that we use sort fileinpu.basket
# or  you can do it with R.
# by now the date are in the format yyyymmdd como secuenceID
# sequenceid cod_client
# eventid date
# mayor información http://en.wikibooks.org/wiki/Data_Mining_Algorithms_In_R/Sequence_Mining/SPADE
 


library(Matrix)
library(arules)
library(arulesSequences)

x = read_baskets("~/datamining/apriori/data/transacciones_v10.basket",sep=",",info=c( "sequenceID", "eventID","SIZE"))

head(dfx)
inspect(x[1:10])
s1 <- cspade(x, parameter = list(support = 0.1), control = list(verbose = TRUE))
inspect(s1)
summary(s1)


#otras cosas
r1 <- ruleInduction(s1, confidence = 0.8, control= list(verbose = TRUE))
inspect(r1)
summary(r1)
as(s1, "data.frame")




