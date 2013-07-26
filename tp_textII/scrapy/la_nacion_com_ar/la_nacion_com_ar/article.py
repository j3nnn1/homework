#!/usr/bin/python
# -*- coding: utf-8 -*-
# j3nnn1 - 0.0.0 -

from scrapy.item import Item, Field

class ArticleItem(Item):
    body = Field()
    title = Field()

