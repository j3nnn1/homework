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
from la_nacion_com_ar.items import LaNacionComArItem
from HTMLParser import HTMLParser
import unicodedata
import HTMLParser
import xml.etree.ElementTree

reload(sys)
sys.setdefaultencoding('ascii')

class LanacionSpider(BaseSpider):
   name = "lanacion" 
   allowed_domains = ["www.lanacion.com.ar"]
   start_urls = [
    "http://www.lanacion.com.ar/1607024-la-cosecha-record-no-le-basto-al-gobierno-para-sumar-reservas-en-el-banco-central",
    "http://www.lanacion.com.ar/1607004-ypf-preve-un-petroleo-30-mas-caro",
    "http://www.lanacion.com.ar/1607006-esperan-que-siga-fuerte-el-consumo-hasta-fin-de-ano-pero-se-debilita-en-los-sectores-bajos",
    "http://www.lanacion.com.ar/1607007-se-extiende-el-furor-por-los-cupones-en-divisas",
    "http://www.lanacion.com.ar/1607009-suiza-dara-datos-pero-acoto-la-ambicion-de-la-afip",
    "http://www.lanacion.com.ar/1598293-la-soja-y-el-maiz-se-negociaron-sin-cambios",
    "http://www.lanacion.com.ar/1598296-se-extendio-el-rebote-entre-los-activos-locales",
    "http://www.lanacion.com.ar/1598376-que-pasa",
   ]
   def parse(self, response):
       hxs = HtmlXPathSelector(response)
       item = LaNacionComArItem()
       item['title'] = hxs.select('/html/body/section/section/section[6]/article/section[2]/h1').extract()
       item['content']= hxs.select('//*[@id="cuerpo"]').extract()
       item['content'] = HTMLParser.HTMLParser().unescape(item['content'])[0].encode("utf-8")
       item['title'] = HTMLParser.HTMLParser().unescape(item['title'])[0].encode("utf-8")
       item['title'] = item['title'].replace(' ', '_').replace(',','').replace('"','').replace(';','').replace("'","")
       item['content'] = item['content'].replace(',','').replace('"','').replace("'","").replace(';', '')

       return item       

   def remove_tags(self, text):
       ''.join(xml.etree.ElementTree.fromstring(text).itertext())
