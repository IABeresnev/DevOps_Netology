#!/bin/bash

function checkip {
if [ $# -eq 0 ]
then
echo -1
else
  local arr
  arr=$@
  x=0
  while ((1==1))
  do
  for i in ${arr[@]}
    do
    nc -zv -w2 $i 80 >/dev/null 2>&1
    if (($? != 0))
    then
      echo $i >> error.log
      exit
    fi
    done
  sleep 10
  done
fi
}
checkip 173.194.222.113 87.250.250.242 192.168.0.1 87.250.250.242
