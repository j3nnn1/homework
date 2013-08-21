#!/usr/bin/python
# -*- coding: utf-8 -*-
# convert Mallet format ( document-composition )
# to a edge-lists csv which contain source, target, value
# or to gml which contain source, target, value
# csv format
# source target weigth
# index 0 and 1 word reference
# index > 2 topic and incidence
# threshold

threshold  = 0.5
topic_prefix = 20000


compo = open("noticias_composition.txt", "r")
out = open("noticias_composition.txt.edgelists", "w")

def getCountWord(topics):
    count=0
    for topic in topics:
        val = topic.split(':')[1]
        count = count + int(val)
    return count


for line in compo:
    fields = line.split(' ')
    fields[-1] = fields[-1].strip()
    source = fields[0]
    topics = fields[2:]
    incidence_word = getCountWord(topics)
    
    for topic in topics:
        topic_name = float(topic.split(':')[0]) + float(topic_prefix)
        topic_val = topic.split(':')[1]
        weigth = float(topic_val)/float(incidence_word)
        if (weigth > threshold):
            out.write(source+','+str(topic_name)+','+str(weigth)+"\n")








