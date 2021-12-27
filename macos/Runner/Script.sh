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

current=`pwd`
#echo $profix$current
#cd current

#user=`who am i`
#echo $current

#process_run1="$current/.config/tekartik/process_run"
#process_run2="$current/.config/tekartik/process_run"
# sudo -S visudo
flutter_which=`which flutter`
fileName=env.yaml

echo  $profix$process_run1
echo  $profix: $flutter_which
if [ -d $process_run1 ];then
    if [ -f "$process_run1/$fileName" ];then
        rm -rf $process_run1/$fileName
        dirAndName="$process_run1/$fileName"
        touch $dirAndName
        echo "" >> $dirAndName
        echo "path:" >> $dirAndName
        echo "- :$flutter_which" >>$dirAndName
    #      <<EOF
        echo "文件创建完成2"
        #echo "$process_run1/$fileName 文件存在 "
    else
#        echo "$? 文件不存在"
#        echo "文件不存在"
        dirAndName="$process_run1/$fileName"
        touch $dirAndName
        echo "" >> $dirAndName
        echo "path:" >> $dirAndName
        echo "- :$flutter_which" >>$dirAndName
    #      <<EOF
        echo "文件创建完成3"
    fi
else
      mkdir -p $process_run1
      dirAndName="$process_run1/$fileName"
      touch $dirAndName
      echo "" >> $dirAndName
      echo "path:" >> $dirAndName
      echo "- :$flutter_which" >>$dirAndName
#      <<EOF
      echo "文件创建完成1"
fi
