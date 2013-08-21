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
from infobae.items import InfoBaeItem
from HTMLParser import HTMLParser
import unicodedata
import HTMLParser
import xml.etree.ElementTree

reload(sys)
sys.setdefaultencoding('ascii')

class InfoBaeSpider(BaseSpider):
   name = "infobae" 
   allowed_domains = ["www.infobae.com"]
   start_urls = [
    "http://www.infobae.com/notas/723794-El-precio-de-las-materias-primas-cayo-17-en-julio",
    "http://www.infobae.com/notas/723793-El-desarrollador-TGLT-anuncio-inversiones-por-mas-de-1700-millones-en-cinco-anos",
    "http://www.infobae.com/notas/723786-Estiman-que-la-economia-le-esta-dando-tiempo-a-la-politica-para-hacer-correcciones",
    "http://www.infobae.com/notas/723780-Calculan-un-elevado-impacto-cambiario-y-fiscal-por-la-caida-de-la-soja",
    "http://www.infobae.com/notas/723772-Avanza-el-proyecto-para-dar-incentivos-fiscales-para-seguros-de-vida",
    "http://www.infobae.com/notas/723742-Brasil-desacelero-fuerte-su-tasa-de-inflacion",
    "http://www.infobae.com/notas/723728-A-paso-lento-la-Supercard-ya-se-ofrece-en-algunos-supermercados",
    "http://www.infobae.com/notas/723691-El-Cedin-monopoliza-las-compras-de-un-mercado-inmobiliario-sin-movimiento",
    "http://www.infobae.com/notas/723680-El-titular-de-la-AFIP-duda-del-proyecto-para-gravar-la-renta-financiera",
    "http://www.infobae.com/notas/723678-Argentina-es-el-segundo-pais-de-Sudamerica-con-mayor-desocupacion",
    "http://www.infobae.com/notas/723676-Prometen-que-hoy-podra-comenzar-a-gestionarse-la-Supercard",
    "http://www.infobae.com/notas/723675-La-UIA-busca-reunirse-con-la-Presidente-por-las-trabas-aduaneras",
    "http://www.infobae.com/notas/723643-La-soja-continua-en-su-nivel-de-precios-mas-bajo-desde-febrero-de-2012",
    "http://www.infobae.com/notas/723640-Inflacion-e-infraestructura-los-problemas-que-deberan-enfrentar-los-politicos",
    "http://www.infobae.com/notas/723602-Mas-de-40-de-los-desempleados-enfrentan-mas-trabas-para-ocuparse",
    "http://www.infobae.com/notas/723598-El-indicador-que-anticipa-el-PBI-cayo-en-junio-por-tercer-mes-consecutivo",
    "http://www.infobae.com/notas/723587-Venezuela-registra-una-inflacion-de-42-anual",
    "http://www.infobae.com/notas/723574-Uruguay-emitira-un-bono-y-recomprara-deuda",
    "http://www.infobae.com/notas/723570-El-deficit-comercial-con-EEUU-se-redujo-en-el-primer-semestre-del-ano",
    "http://www.infobae.com/notas/723564-Las-posiciones-de-trabajo-mas-dificiles-de-cubrir",
    "http://www.infobae.com/notas/723494-Se-postergo-otra-vez-la-emision-de-la-Supercard",
    "http://www.infobae.com/notas/723493-El-Gobierno-busca-avanzar-en-la-regulacion-del-mercado-de-los-granos",
    "http://www.infobae.com/notas/723453-Gobierno-extendera-controles-sobre-el-dolar-en-la-Bolsa-hasta-octubre",
    "http://www.infobae.com/notas/723452-La-Provincia-emitio-otro-bono-ajustable-por-el-dolar-oficial",
    "http://www.infobae.com/notas/723441-El-Presupuesto-2014-mantendra-la-obra-publica-y-el-desendeudamiento",
    "http://www.infobae.com/notas/723439-La-mitad-de-los-comercios-portenos-tuvo-caidas-de-ventas-en-julio",
    "http://www.infobae.com/notas/723429-El-salario-promedio-de-la-economia-subio-21-en-junio-segun-el-Indec",
    "http://www.infobae.com/notas/723419-Para-Curia-la-economia-esta-mejor-pero-vienen-anos-muy-dificiles",
    "http://www.infobae.com/notas/723415-Brasil-dispuesto-a-sacrificar-el-crecimiento-para-frenar-la-inflacion",
    "http://www.infobae.com/notas/723414-El-mercado-de-autos-se-afirma-en-la-mayor-demanda-de-importados",
    "http://www.infobae.com/notas/723411-El-clima-favorable-en-EEUU-mantiene-a-los-granos-en-precios-minimos-del-ano",
    "http://www.infobae.com/notas/723408-La-venta-de-motos-con-un-nuevo-record-en-julio",
    "http://www.infobae.com/notas/723399-Vizora-Desarrollos-Inmobiliarios-invierte-500-millones-en-Puerto-Madero",
    "http://www.infobae.com/notas/723395-ARBA-implemento-el-plan-para-regularizar-obras-no-declaradas",
    "http://www.infobae.com/notas/723394-La-AFIP-paso-a-27-mil-monotributistas-al-regimen-general",
    "http://www.infobae.com/notas/723314-Comprar-un-kilo-de-lomo-cuesta-menos-que-las-hamburguesas-congeladas",
    "http://www.infobae.com/notas/723312-Impulsadas-por-el-aguinaldo-en-julio-las-ventas-crecieron-un-23",
    "http://www.infobae.com/notas/723269-Sera-obligatorio-tener-una-tarjeta-de-credito-para-tramitar-la-Supercard",
    "http://www.infobae.com/notas/723254-Preocupa-la-falta-de-dolares-no-tanto-el-tipo-de-cambio-dijo-la-UIA",
    "http://www.infobae.com/notas/723105-El-Central-se-quedo-con-1-de-cada-100-dolares-liquidados-de-la-cosecha",
    "http://www.infobae.com/notas/723104-Chevron-confia-en-que-Argentina-volvera-a-exportar-hidrocarburos",
    "http://www.infobae.com/notas/723092-El-blanqueo-sigue-sumando-nuevos-adherentes-pero-de-forma-muy-lenta",
    "http://www.infobae.com/notas/723035-La-tasa-de-inflacion-en-Uruguay-se-acelero-a-08-en-julio",
    "http://www.infobae.com/notas/723034-Guia-de-salarios-cuanto-ganan-los-argentinos-en-cada-region-del-pais",
    "http://www.infobae.com/notas/723033-La-Argentina-y-Sudafrica-acordaron-intercambiar-datos-fiscales",
    "http://www.infobae.com/notas/723032-Otro-precio-minimo-del-ano-para-la-soja-en-EEUU",
    "http://www.infobae.com/notas/723025-Como-sin-crear-impuestos-aumento-30-la-presion-tributaria",
    "http://www.infobae.com/notas/723020-En-7-meses-el-BCRA-se-quedo-solo-con-1-de-los-dolares-de-las-cosechas",
    "http://www.infobae.com/notas/722940-La-inflacion-Moyano-acumula-12-durante-el-2013",
    "http://www.infobae.com/notas/722937-Las-naftas-pueden-aumentar-17-hasta-octubre",
   ]
   def parse(self, response):
       hxs = HtmlXPathSelector(response)
       item = InfoBaeItem()

       item['title'] = hxs.select('/html/body/div[1]/div[3]/h1').extract()
       item['content']= hxs.select('/html/body/div[1]/div[5]/div[1]/div/div[1]/div[3]').extract()
       item['content']= item['content'] + hxs.select('/html/body/div[1]/div[5]/div[1]/div/div[1]/div[4]').extract()

       item['content'] = HTMLParser.HTMLParser().unescape(item['content'])[0].encode("utf-8")
       item['title'] = HTMLParser.HTMLParser().unescape(item['title'])[0].encode("utf-8")
       item['title'] = item['title'].replace(' ', '_').replace(',','').replace('"','').replace(';','').replace("'","")
       item['content'] = item['content'].replace(',','').replace('"','').replace("'","").replace(';', '')

       return item       

   def remove_tags(self, text):
       ''.join(xml.etree.ElementTree.fromstring(text).itertext())
