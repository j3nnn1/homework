#!/usr/bin/python
# -*- coding: utf-8 -*-

from random import random as rand
arff = "training_semidiscretize.arff"
P = 0.025 # 0 .. 1 percent of missing values


while (P<=0.85):
    arff_missing = 'training_semidiscretize_'+str(P)+'.arff'
    with open(arff) as data, open(arff_missing, 'w') as data_missing:
        for line in data:
            data_missing.write(line)
            if (line.find("@data") == 0):
                break
        for line in data:
            l = line.split(",")
            data_missing.write(",".join(
                [x if rand() > P else '?' for x in l[:-1]]
                + l[-1:]))

    P = P +0.025

