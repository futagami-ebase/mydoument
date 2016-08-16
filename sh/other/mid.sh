#!/bin/bash -eu

# ファイルの(byte or lineで)指定した中間部分を標準出力する
#
# example)
# 1. 5byte目から8byte出力
#  mid ./tmp.txt -c 5-8
#
# 2. 3行目から5行出力
#  mid ./tmp.txt -n3-5
#
# 3. 3行目から最終行まで出力
#  mid ./tmp.txt -n 3-
function mid {

  local usage="usage: mid [file ...] [-n lines-list | -c bytes-list]"

  # parameter取得
  if [ -t 0 ] && [ $# -gt 1 ]; then # 通常入力
    local file_data=$1;
    opts="_"$(echo "_$@" | cut -d " " -f 2-)
  elif [ ! -t 0 ] && [ $# -gt 0 ]; then # パイプ利用時
    local file_data="-";
    opts=$(echo "_$@" | cut -d " " -f 1-)
  else 
    echo $usage
    return
  fi

  # parameterチェック
  local opt=$(echo $opts | tr -d " " | tr -d "_")
  if [ -z $(echo $opt | grep -E "^\-(n|c)\d+-") ]; then
    echo $usage
    return
  fi

  # 出力処理用のparameter取り出し
  output_file=$(cat $file_data)
  local cut_opt=$(echo $opt | cut -c 2-2)
  if [ "$cut_opt" = "n" ]; then
    local size_limit=$(echo $output_file | wc -l | tr -d " ")
  else
    local size_limit=$(echo $output_file | wc -c | tr -d " ")
  fi

  local offset=$(echo $opt | cut -c 3- | cut -d "-" -f 1-1)
  local length=$(echo $opt | cut -c 3- | cut -d "-" -f 2-2)
  [ -z $length ] && length=$size_limit
  if [ -z $(echo $length | grep -E "^\d+$") ]; then
    echo $usage
    return
  fi

  local select_size=$(expr $offset + $length - 1)

  # 出力処理
  if [ $select_size -le $size_limit ]; then
    echo $output_file | head -$cut_opt$select_size | tail -$cut_opt$length
  else
    echo $output_file | tail -$cut_opt$(expr $size_limit - $offset + 1)
  fi
}
