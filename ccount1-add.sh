#!/bin/bash
# �o��{���Ψӫإ߷s�W�b���A�\�঳�G
# 1. �ˬd account1.txt �O�_�s�b�A�ñN���ɮפ����b�����X�F
# 2. �إߤW�z�ɮת��b���F
# 3. �N�W�z�b�����K�X�׭q�����y�j��Ĥ@���i�J�ݭn�ק�K�X�z���榡�C
# 2009/03/04    VBird
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

# �ˬd account1.txt �O�_�s�b
if [ ! -f account1.txt ]; then
	echo "�һݭn���b���ɮפ��s�b�A�Ыإ� account1.txt �A�C��@�ӱb���W��"
	exit 1
fi

usernames=$(cat account1.txt)

for username in $usernames
do
	useradd $username
    # ubuntu no --stdin cmd;
	#echo $username | passwd --stdin $username
	echo "$username:$username" | chpasswd
	chage -d 0 $username
done

