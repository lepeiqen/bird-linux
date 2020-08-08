#!/bin/bash
# ====================================================================
# �ϥΪ̰Ѽƿ�J��m�G
# basedir=�A�Ψ��x�s���}���ҹw�p�ƥ�����Ƥ��ؿ�(�пW���ɮרt��)
basedir=~/BackUp/weekly

# ====================================================================
# ���U�Ф��n�ק�F�I�ιw�]�ȧY�i�I
PATH=/bin:/usr/bin:/sbin:/usr/sbin; export PATH
export LANG=C

# �]�w�n�ƥ����A�Ȫ��]�w�ɡA�H�γƥ����ؿ�
named=$basedir/named
postfixd=$basedir/postfix
vsftpd=$basedir/vsftp
sshd=$basedir/ssh
sambad=$basedir/samba
wwwd=$basedir/www
others=$basedir/others
userinfod=$basedir/userinfo
# �P�_�ؿ��O�_�s�b�A�Y���s�b�h���H�إߡC
for dirs in $named $postfixd $vsftpd $sshd $sambad $wwwd $others $userinfod
do
	[ ! -d "$dirs" ] && mkdir -p $dirs
done

# 1. �N�t�ΥD�n���A�Ȥ��]�w�ɤ��O�ƥ��U�ӡA�P�ɤ]�ƥ� /etc �����C
cp -a /var/named/chroot/{etc,var}	$named
cp -a /etc/postfix /etc/dovecot.conf	$postfixd
cp -a /etc/vsftpd/*			$vsftpd
cp -a /etc/ssh/*			$sshd
cp -a /etc/samba/*			$sambad
cp -a /etc/{my.cnf,php.ini,httpd}	$wwwd
cd /var/lib
  tar -jpc -f $wwwd/mysql.tar.bz2 	mysql
cd /var/www
  tar -jpc -f $wwwd/html.tar.bz2 	html cgi-bin
cd /
  tar -jpc -f $others/etc.tar.bz2	etc
cd /usr/
  tar -jpc -f $others/local.tar.bz2	local

# 2. ����ϥΪ̰ѼƤ譱
cp -a /etc/{passwd,shadow,group}	$userinfod
cd /var/spool
  tar -jpc -f $userinfod/mail.tar.bz2	mail
cd /
  tar -jpc -f $userinfod/home.tar.bz2	home
cd /var/spool
  tar -jpc -f $userinfod/cron.tar.bz2	cron at




