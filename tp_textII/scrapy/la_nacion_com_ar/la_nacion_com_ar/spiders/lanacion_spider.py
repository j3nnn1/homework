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
        "http://www.lanacion.com.ar/1604151-el-gobierno-ratifico-a-cesar-milani-es-el-jefe-del-ejercito",
        "http://www.lanacion.com.ar/1604221-los-candidatos-de-unen-debatieron-con-duras-criticas-al-gobierno",
        "http://www.lanacion.com.ar/1604148-cristina-kirchner-santiago-del-estero",
        "http://www.lanacion.com.ar/1603840-el-doble-estandar-de-los-derechos-humanos-en-la-politica-exterior-de-cristina",
        "http://www.lanacion.com.ar/1602716-abajo-colon-arriba-chevron",
   ]
   def parse(self, response):
       hxs = HtmlXPathSelector(response)
       item = LaNacionComArItem()
       item['title'] = hxs.select('/html/body/section/section/section[6]/article/section[2]/h1').extract()
       item['content']= hxs.select('//*[@id="cuerpo"]').extract()
       item['content'] = HTMLParser.HTMLParser().unescape(item['content'])
       item['title'] = HTMLParser.HTMLParser().unescape(item['title'])
       item['title'] = str(item['title']).replace(' ', '_').replace(',','').replace('"','').replace(';','').replace("'","")
       item['content'] = str(item['content']).replace(',','').replace('"','').replace("'","").replace(';', '')

       return item       

   def remove_tags(self, text):
       ''.join(xml.etree.ElementTree.fromstring(text).itertext())
