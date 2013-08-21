#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# convert format mallet file to csv
# doc no, name, topic topic-value ...
# 0 , 1, 2
#
# docno => name, topics => topico1 => val_topico1
#
compo = open("iteracion4/noticias_composition.4.10.txt", "r")
out = open("iteracion4/noticias_composition.4.10.txt.csv", "w")

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
    get_topics(topics)
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
    

# Main Script
removing_header(compo)
# getting data structure
composition  = get_composition(compo)
# doing header csv
csv = csv_header()
csv_header = ','.join(csv)
out.write(csv_header)

#doing body csv
for doc, attrs in composition.items():
    csv_doc = []
    document_no = doc
    name = composition[document_no]['name']

    csv_doc.append(document_no)
    csv_doc.append(name)

    for attr, val in attrs.items():
        if attr=='topics':
            for name, val in val.items():
                csv_doc.append(val)

    csv_doc[-1] = csv_doc[-1] + "\n"
    out.write(','.join(csv_doc))
