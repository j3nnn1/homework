#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# convert format mallet file to csv
# doc no, name, topic topic-value ...
# 0 , 1, 2
#
# docno => name, topics => topico1 => val_topico1
#
import json
threshold = float(0.998)
compo = open("iteracion8/noticias_composition.16.5.txt", "r")
out = open("iteracion8/noticias_composition.16.5.json", "w")

composition = {}

def is_pairs(num):
    return num%2 

def get_topics(topics):
    newtopic = {}
    for i, topic in enumerate(topics):
        if is_pairs(i):
            newtopic[topics[i-1]] =  topics[i]
    return newtopic

def get_document(name, topics):
    document = {}
    document['name'] = name
    document['topics'] = get_topics(topics)
    return document

def csv_header():
    csv_fields = ['doc_no', 'name']
    for key, val in composition['1']['topics'].items():
        csv_fields.append(key)

    csv_fields[-1] = csv_fields[-1]+"\n"
    return csv_fields

def removing_header(compo):
    header = compo.readline() #//removing header

def get_composition(compo):
    composition = {}
    for line in compo:
        fields = []
        fields = line.split("\t")
        doc_no = fields[0]
        name = fields[1]
        composition[doc_no]  = get_document(name, fields[2:])

    return composition
    
def create_node(name):
    child = {}
    child['name'] = name
    child['children'] =[]
    return child

def create_parent():
    parent = {} 
    parent['name'] = 'economia'
    parent['children'] = []
    return parent

def create_leaf(name, size):
    attr = {}
    attr['name']=name
    attr['size']=size
    return attr
    
def get_array_topics(composition):
    topics = []
    for keys, val in composition['1']['topics'].items():
        topics.append(keys)
    return topics

# Main Script
removing_header(compo)
# getting data structure
composition = {}
composition  = get_composition(compo)
# getting topícs
topics = get_array_topics(composition)
#create parent
treejson = create_parent()

for i, topic in enumerate(topics):
    treejson['children'].append(create_node(topic))
    for doc, val in composition.items():
        name = composition[doc]['name']
        size = composition[doc]['topics'][topic]

        print float(size)

        if (float(size) > threshold):
            leaf = create_leaf(name, size)
            treejson['children'][i]['children'].append(leaf)
out.write(json.dumps(treejson))
print "Listo!"
