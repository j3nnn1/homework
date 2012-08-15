#!/usr/bin/python
# -*- coding: utf-8 -*-
# j3nnn1 - 0.0.0 -
#Solo python2
#toma en cuenta el primer campo como id de transaccion.

inputfile = open("../data/transacciones_Nofrecuente.csv", "r")
outputfile = open("transacciones.basket", "w")

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
    newfile[k].insert(0,k)
    linenew = ','.join(newfile[k])
    outputfile.write(linenew+"\n")
    #print ";".join(newfile[k])
