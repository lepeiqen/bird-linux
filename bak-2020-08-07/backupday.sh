#!/bin/bash
# =========================================================
# �п�J�A�A�Q���ƥ���Ʃ�m�쨺�ӿW�ߪ��ؿ��h
basedir=/backup/daily/

# =========================================================
PATH=/bin:/usr/bin:/sbin:/usr/sbin; export PATH
export LANG=C
basefile1=$basedir/mysql.$(date +%Y-%m-%d).tar.bz2
basefile2=$basedir/cgi-bin.$(date +%Y-%m-%d).tar.bz2
[ ! -d "$basedir" ] && mkdir $basedir

# 1. MysQL (��Ʈw�ؿ��b /var/lib/mysql)
cd /var/lib
  tar -jpc -f $basefile1 mysql

# 2. WWW �� CGI �{�� (�p�G���ϥ� CGI �{������)
cd /var/www
  tar -jpc -f $basefile2 cgi-bin
