#!/usr/bin/python
# -*- coding: utf-8 -*-
# j3nnn1 - 0.0.0 -

import sys
from scrapy.spider import BaseSpider
from scrapy.http import Request
from scrapy.http import FormRequest
from scrapy.selector import HtmlXPathSelector
from scrapy.item import Item, Field
from scrapy import log
from el_universo.items import ElUniversoItem
from HTMLParser import HTMLParser
import unicodedata
import HTMLParser
import xml.etree.ElementTree

reload(sys)
sys.setdefaultencoding('ascii')

class EluniversoSpider(BaseSpider):
   name = "eluniverso" 
   allowed_domains = ["www.eluniverso.com"]
   start_urls = [
    "http://www.eluniverso.com/noticias/2013/08/04/nota/1242016/baki-concepto-yasuni-itt-aun-no-es-aceptado",
    "http://www.eluniverso.com/noticias/2013/08/03/nota/1237101/cementera-estatal-busca-socio-estrategico",
    "http://www.eluniverso.com/noticias/2013/08/03/nota/1236591/agro",
    "http://www.eluniverso.com/noticias/2013/08/03/nota/1237096/se-reduce-saldo-negativo-balanza-pagos",
    "http://www.eluniverso.com/noticias/2013/08/03/nota/1237081/papa-frutilla-mora-ceniza-precios-bajos",
    "http://www.eluniverso.com/noticias/2013/08/03/nota/1236586/diversificar-cultivos-alternativa-rentable",
    "http://www.eluniverso.com/noticias/2013/08/03/nota/1237091/61-empresas-chinas-participaron-rueda-negocios",
    "http://www.eluniverso.com/noticias/2013/08/02/nota/1236106/fmi-propone-espana-pacto-social-que-incluya-rebaja-sueldos",
    "http://www.eluniverso.com/noticias/2013/08/02/nota/1233721/servicios-venta-credito-tienen-limites-julio",
    "http://www.eluniverso.com/noticias/2013/08/02/nota/1233746/salida-atpdea-ya-golpea-exportadores",
   ]
   def parse(self, response):
       hxs = HtmlXPathSelector(response)
       item = ElUniversoItem()

       #item['title'] = hxs.select('/html/body/div[4]/section/div/div/div[4]/div/div[2]/div/div/article/header/h1').extract()
       item['content']= hxs.select('//*[@id="block-system-main"]/div/div').extract()
       item['content'] = HTMLParser.HTMLParser().unescape(item['content'])[0].encode('utf-8')
       #item['title'] = HTMLParser.HTMLParser().unescape(item['title'])
       #item['title'] = str(item['title']).replace(' ', '_').replace(',','').replace('"','').replace(';','').replace("'","")
       item['content'] = item['content'].replace(',','').replace('"','').replace("'","").replace(';', '')

       return item       

   def remove_tags(self, text):
       utf-8''.join(xml.etree.ElementTree.fromstring(text).itertext())
