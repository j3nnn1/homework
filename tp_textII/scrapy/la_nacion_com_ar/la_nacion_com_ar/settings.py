# Scrapy settings for la_nacion_com_ar project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/topics/settings.html
#

BOT_NAME = 'la_nacion_com_ar'

SPIDER_MODULES = ['la_nacion_com_ar.spiders']
NEWSPIDER_MODULE = 'la_nacion_com_ar.spiders'
LOG_LEVEL = 'INFO'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'la_nacion_com_ar (+http://www.yourdomain.com)'
