#!/bin/ksh

[[ $# -ne 1 ]] && { echo -e "$0: The right arguments have not been passed.\n\n Usage: $0 <snapshot file>\n" >&2; exit 1; }
[[ ! -f "$1" ]] && { echo -e "$0: The file \"$1\" does not exist. \n\n Usage: $0 <snapshot file>\n" >&2; exit 2; }

LOG_FILE="/var/log/binchecker"
echo -e "\n###########################\n\n	Analysis of the day: $(date)\n\n###########################\n" >> $LOG_FILE

IFS=:
for file in /bin/* /sbin/* /usr/bin/* /usr/sbin/*
do
   isNew="true"
   while read perm checksum filePath
      do
         if [[ $file == $filePath ]] 
         then 
            perm1=$(stat -c "%A" "$file")
            checksum1=$(md5sum "$file")
            checksum1=${checksum1/ *}
            [[ $perm1 != $perm ]] && echo "The permissions of \"$file\" has been modified, originals:\"$perm\" current:\"$perm1\"."
            [[ $checksum1 != $checksum ]] && echo "The content of \"$file\" has been modified, original checksum:\"$checksum\" current checksum:\"$checksum1\"."
            isNew="false"
            break
         fi
   done < "$1"		
   [[ $isNew == "true" ]] && echo "The file \"$file\" is new."
done >> $LOG_FILE


while read perms checksum filePath
do
   [[ ! -f "$filePath" ]] && echo "The file \"$filePath\" has been deleted."
done < "$1" >> $LOG_FILE




