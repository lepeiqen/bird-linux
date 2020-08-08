#!/bin/bash
#
# 這支程式主要在幫您建立大量的帳號之用，更多的使用方法請參考：
# http://linux.vbird.org/linux_basic/0410accountmanager.php#manual_amount
#
# 本程式為鳥哥自行開發，在 CentOS 5.x 上使用沒有問題，
# 但不保證絕不會發生錯誤！使用時，請自行負擔風險～
#
# History:
# 2005/09/05    VBird   剛剛才寫完，使用看看先～
# 2009/03/04	VBird	加入一些語系的修改與說明，修改密碼產生方式 (用 openssl)
export LANG=zh_TW.big5
export PATH=/sbin:/usr/sbin:/bin:/usr/bin
accountfile="user.passwd"

# 1. 進行帳號相關的輸入先！
echo ""
echo "例如我們崑山四技的學號為： 4960c001 到 4960c060 ，那麼："
echo "帳號開頭代碼為         ：4"
echo "帳號層級或年級為       ：960c"
echo "號碼數字位數為(001~060)：3"
echo "帳號開始號碼為         ：1"
echo "帳號數量為             ：60"
echo ""
read -p "帳號開頭代碼 ( Input title name, ex> std )======> " username_start
read -p "帳號層級或年級 ( Input degree, ex> 1 or enter )=> " username_degree
read -p "號碼部分的數字位數 ( Input \# of digital )======> " nu_nu
read -p "起始號碼 ( Input start number, ex> 520 )========> " nu_start
read -p "帳號數量 ( Input amount of users, ex> 100 )=====> " nu_amount
read -p "密碼標準 1) 與帳號相同 2)亂數自訂 ==============> " pwm
if [ "$username_start" == "" ]; then
        echo "沒有輸入開頭的代碼，不給你執行哩！" ; exit 1
fi
# 判斷數字系統
testing0=$(echo $nu_nu     | grep '[^0-9]' )
testing1=$(echo $nu_amount | grep '[^0-9]' )
testing2=$(echo $nu_start  | grep '[^0-9]' )
if [ "$testing0" != "" -o "$testing1" != "" -o "$testing2" != "" ]; then
        echo "輸入的號碼不對啦！有非為數字的內容！" ; exit 1
fi
if [ "$pwm" != "1" ]; then
        pwm="2"
fi

# 2. 開始輸出帳號與密碼檔案！
[ -f "$accountfile" ] && mv $accountfile "$accountfile"$(date +%Y%m%d)
nu_end=$(($nu_start+$nu_amount-1))
for (( i=$nu_start; i<=$nu_end; i++ ))
do
	nu_len=${#i}
	if [ $nu_nu -lt $nu_len ]; then
		echo "數值的位數($i->$nu_len)已經比你設定的位數($nu_nu)還大！"
		echo "程式無法繼續"
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

# 3. 開始建立帳號與密碼！
echo "帳密建置中，請稍待片刻！"
cat "$accountfile" | cut -d':' -f1 | xargs -n 1 useradd -m
chpasswd < "$accountfile"
pwconv
echo "OK！建立完成！"
