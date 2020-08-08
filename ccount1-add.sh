#!/bin/bash
# 這支程式用來建立新增帳號，功能有：
# 1. 檢查 account1.txt 是否存在，並將該檔案內的帳號取出；
# 2. 建立上述檔案的帳號；
# 3. 將上述帳號的密碼修訂成為『強制第一次進入需要修改密碼』的格式。
# 2009/03/04    VBird
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

# 檢查 account1.txt 是否存在
if [ ! -f account1.txt ]; then
	echo "所需要的帳號檔案不存在，請建立 account1.txt ，每行一個帳號名稱"
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

