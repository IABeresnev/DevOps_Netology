#!/bin/bash

function checkip {
if [ $# -eq 0 ]
then
echo -1
else
  local arr
  arr=$@
  x=0
  while ((x<5))
  do
  echo "Next try" >> task3.log
  for i in ${arr[@]}
    do
    nc -zv -w2 $i 80 >/dev/null 2>&1
    if (($? != 1))
    then
      echo $(date)  $i "is good" >> task3.log
    else
      echo $(date)  $i "is down" >> task3.log
    fi
    done
  x=$(($x+1))
  done
fi
}
checkip 192.168.0.1 173.194.222.113 87.250.250.242
