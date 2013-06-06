#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys, os
import subprocess

if len(sys.argv) < 3:
  print("Usage python3 weka.py <pathtoweka> <filetoprocess> <options>")
  quit()
else:
    options='0 35'


pathtoweka = sys.argv[1]
fileinput  = sys.argv[2]
intervalo = options.split(' ')
cont = 5
ruido=0
params = [ 'java',
           '-classpath',
           './weka-3-6-7/weka.jar',
           'weka.filters.unsupervised.attribute.AddNoise',
           '-P 0',
           '-i score_consume.arff',
           '-o output.arff'
        ]

while ruido < int(intervalo[-1]):
    
    ruido = ruido + cont
    params[4] = '-P 0'+ str(ruido) 
    params[6] = '-o output_'+str(ruido)+'.arff'  
    print ' '.join(params)
    subprocess.call(params)
    quit()

