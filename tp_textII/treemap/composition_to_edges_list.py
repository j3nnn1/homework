#!/usr/bin/python
# -*- coding: utf-8 -*-
# convert Mallet format ( document-compositions)
# to a edge-lists csv which contain source, target, value
# or to gml which contain source, target, value
# source target weigth
# threshold take only topics with a percentage of composition upper to this variable

#fields[0] doc no
#fields[1] nombre_documento


threshold = float(0.992)
topic_prefix = 20000


compo = open("iteracion4/noticias_composition.4.5.txt", "r")
out = open("iteracion4/noticias_composition.4.5.txt.edgeslist", "w")


def getCountWord(topics):
    count=0
    for topic in topics:
        val = topic.split(':')[1]
        count = count + int(val)
    return count

def get_topics(topics):
    return topics

def is_pairs(num):
    return num%2

# deleting first line
compo.readline()

for line in compo:
    fields = line.split("\t")
    fields[-1] = fields[-1].strip()
    docno = fields[0]
    docname = fields[1]
    topics = fields[2:]
    index_final = len(topics)

    for i,topic in enumerate(topics):
        if (not is_pairs(i) and i < (index_final-1)):
            if (float(topics[i+1]) > threshold):           
                #do line
                line = docno+", "+str(topic_prefix + float(topic))  + ', ' + topics[i+1]
                line = line + "\n"
                out.write(line)
