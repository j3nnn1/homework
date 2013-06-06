#!/usr/bin/python2
# -*- coding: utf-8 -*-
# j3nnn1 - 0.0.0 -
#inputfile "../data/transaccionesarulessecuences3.csv"
#outputfile "../data/transaccionesarulessecuences3.csv"
#Solo con python2

import sys

if len(sys.argv) < 2:
   print 'Usage: singletobasket.py <ArchivoSingledeEntrada.csv> <ArchivoBasketdeSalida.csv>' 
else:
    isingle = sys.argv[1]
    obasket = sys.argv[2]

inputfile = open(isingle, "r")
outputfile = open(obasket, "w")

newfile ={}

for line in inputfile:
    fields = line.split(',')
    newfile[fields[0]]=[]

inputfile.seek(0)

for line in inputfile:
    fields = line.split(',')
    for i, v in enumerate(fields):
        if i>0:
            v = v.replace("\n", '')
            if v not in newfile[fields[0]]: 
                newfile[fields[0]].append(v)


#print type(newfile)
for k, v in newfile.iteritems():
    #newfile[k].insert(0,k)
    linenew = ','.join(newfile[k])
    outputfile.write(linenew+"\n")
    #print ";".join(newfile[k])
