#!/bin/ksh


for file in /bin/* /sbin/* /usr/bin/* /usr/sbin/*
do
   echo $(stat -c "%A" "$file"):$(md5sum "$file" | tr -s " " ":")
done



