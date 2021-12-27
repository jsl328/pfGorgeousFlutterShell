#!/bin/sh

#  Script.sh
#  Runner
#
#  Created by jiangsl on 2021/12/24.
#

# 这里cd到用户目录，然后打印这个目录下的文件
home="$PROJECT_DIR"

#flutter_which=$(which flutter)
#echo "sssss: $flutter_which"
#exit(0)

#添加日志时间戳
function fn_showlog()
{
  local curtime;
  curtime=`date +"%Y%m%d-%H:%M:%S"`
  echo "$curtime ------ $1";
}

profix="profix:"

#current=`pwd`
#echo $profix$current
#cd current

#user=`who am i`
#echo $current

#process_run1="$current/.config/tekartik/process_run"
#process_run2="$current/.config/tekartik/process_run"
# sudo -S visudo
flutter_which=`which flutter`
#fileName=env.yaml

#echo  $profix$home
#echo  $profix: $flutter_which
echo $flutter_which
