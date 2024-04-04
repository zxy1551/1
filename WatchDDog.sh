#!/bin/bash 
###
 # @Author: Your Name your.email@example.com
 # @Date: 2023-12-19 01:23:33
 # @LastEditors: Your Name your.email@example.com
 # @LastEditTime: 2024-04-04 04:27:14
 # @FilePath: /TUP-InfantryVision-2022-main/WatchDDog.sh
 # @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
### 

source /opt/intel/openvino_2021/bin/setupvars.sh
sec=2 
cnt=0 
name=TUP-InfantryVision-2022-main
program_name=Infantry_Vision
#cd /home/tup/Desktop/$name/build/
cd /home/icbk/Desktop/TUP-InfantryVision-2022-main/build

#make clean && 
make -j8 
while [ 1 ] 
do 
    count=`ps -ef | grep $program_name | grep -v "grep" | wc -l`
    echo "Thread count: $count" 
    echo "Expection count: $cnt" 
    if [ $count -ge 1 ]; then 
        echo "The $name is still alive!" 
        sleep $sec 
    else  
        echo "Starting $name..." 
        gnome-terminal -- bash -c  "cd /home/icbk/Desktop/TUP-InfantryVision-2022-main/build/；
        ./$program_name;exec bash;" 
        echo "$name has started!"   
        ((cnt=cnt+1)) 
        sleep $sec 
        if [ $cnt -gt 9 ]; then 
            echo "Reboot!" 
            #reboot 
        fi 
    fi 
done
