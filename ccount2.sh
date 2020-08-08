#!/bin/bash
#
# �o��{���D�n�b���z�إߤj�q���b�����ΡA��h���ϥΤ�k�аѦҡG
# http://linux.vbird.org/linux_basic/0410accountmanager.php#manual_amount
#
# ���{���������ۦ�}�o�A�b CentOS 5.x �W�ϥΨS�����D�A
# �����O�ҵ����|�o�Ϳ��~�I�ϥήɡA�Цۦ�t�᭷�I��
#
# History:
# 2005/09/05    VBird   ���~�g���A�ϥάݬݥ���
# 2009/03/04	VBird	�[�J�@�ǻy�t���ק�P�����A�ק�K�X���ͤ覡 (�� openssl)
export LANG=zh_TW.big5
export PATH=/sbin:/usr/sbin:/bin:/usr/bin
accountfile="user.passwd"

# 1. �i��b����������J���I
echo ""
echo "�Ҧp�ڭ̱X�s�|�ު��Ǹ����G 4960c001 �� 4960c060 �A����G"
echo "�b���}�Y�N�X��         �G4"
echo "�b���h�ũΦ~�Ŭ�       �G960c"
echo "���X�Ʀr��Ƭ�(001~060)�G3"
echo "�b���}�l���X��         �G1"
echo "�b���ƶq��             �G60"
echo ""
read -p "�b���}�Y�N�X ( Input title name, ex> std )======> " username_start
read -p "�b���h�ũΦ~�� ( Input degree, ex> 1 or enter )=> " username_degree
read -p "���X�������Ʀr��� ( Input \# of digital )======> " nu_nu
read -p "�_�l���X ( Input start number, ex> 520 )========> " nu_start
read -p "�b���ƶq ( Input amount of users, ex> 100 )=====> " nu_amount
read -p "�K�X�з� 1) �P�b���ۦP 2)�üƦۭq ==============> " pwm
if [ "$username_start" == "" ]; then
        echo "�S����J�}�Y���N�X�A�����A������I" ; exit 1
fi
# �P�_�Ʀr�t��
testing0=$(echo $nu_nu     | grep '[^0-9]' )
testing1=$(echo $nu_amount | grep '[^0-9]' )
testing2=$(echo $nu_start  | grep '[^0-9]' )
if [ "$testing0" != "" -o "$testing1" != "" -o "$testing2" != "" ]; then
        echo "��J�����X����աI���D���Ʀr�����e�I" ; exit 1
fi
if [ "$pwm" != "1" ]; then
        pwm="2"
fi

# 2. �}�l��X�b���P�K�X�ɮסI
[ -f "$accountfile" ] && mv $accountfile "$accountfile"$(date +%Y%m%d)
nu_end=$(($nu_start+$nu_amount-1))
for (( i=$nu_start; i<=$nu_end; i++ ))
do
	nu_len=${#i}
	if [ $nu_nu -lt $nu_len ]; then
		echo "�ƭȪ����($i->$nu_len)�w�g��A�]�w�����($nu_nu)�٤j�I"
		echo "�{���L�k�~��"
		exit 1
	fi
	nu_diff=$(( $nu_nu - $nu_len ))
	if [ "$nu_diff" != "0" ]; then
		nu_nn=0000000000
		nu_nn=${nu_nn:1:$nu_diff}
	fi
        account=${username_start}${username_degree}${nu_nn}${i}
        if [ "$pwm" == "1" ]; then
                password="$account"
        else
                password=$(openssl rand -base64 6)
        fi
        echo "$account":"$password" | tee -a "$accountfile"
done

# 3. �}�l�إ߱b���P�K�X�I
echo "�b�K�ظm���A�еy�ݤ���I"
cat "$accountfile" | cut -d':' -f1 | xargs -n 1 useradd -m
chpasswd < "$accountfile"
pwconv
echo "OK�I�إߧ����I"
