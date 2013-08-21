#!/usr/bin/python
# -*- coding: utf-8 -*-
# convert Mallet format ( word-topic-counts )
# to a edge-lists csv which contain source, target, value
# or to gml which contain source, target, value
# csv format
# source target weigth
# index 0 and 1 word reference
# index > 2 topic and incidence
# threshold

threshold  = float(0.99999999992)
topic_prefix = 20000


compo = open("iteracion4/noticias_word-topic-counts.4.10.txt", "r")
out = open("iteracion4/noticias_word-topic-counts.4.10.txt.edgeslist", "w")

def getCountWord(topics):
    count=0
    for topic in topics:
        val = topic.split(':')[1]
        count = count + int(val)
    return count


for line in compo:
    incidence_word=0
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








