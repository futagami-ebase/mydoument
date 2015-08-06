#!/bin/sh
 
# ssh ログイン関数 
# 例）bashファイル内で auto_ssh "アドレス" "ID" "パスワード"のファイルを作成しておくと、
# 入力不要のリモートログインシェルファイルになる
auto_ssh() {
host=$1
id=$2
pass=$3
ops=$4
 
expect -c "
set timeout 10
spawn ssh ${ops} ${id}@${host}
expect \"Are you sure you want to continue connecting (yes/no)?\" {
    send \"yes\n\"
    expect \"${id}@${host}'s password:\"
    send \"${pass}\n\"
} \"${id}@${host}'s password:\" {
    send \"${pass}\n\"
}
interact
"
}
