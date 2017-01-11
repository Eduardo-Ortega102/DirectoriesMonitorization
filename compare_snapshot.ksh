#!/bin/ksh

[[ $# -ne 1 ]] && { echo -e "$0: No se han pasado los argumentos adecuados.\n\n Invocación: $0 <fichero de snapshot>\n" >&2; exit 1; }
[[ ! -f "$1" ]] && { echo -e "$0: No existe el fichero \"$1\". \n\n Invocación: $0 <fichero de snapshot>\n" >&2; exit 2; }

LOG_FILE="/var/log/binchecker"
echo -e "\n###########################\n\n	Análisis del día: $(date)\n\n###########################\n" >> $LOG_FILE

IFS=:
for file in /bin/* /sbin/* /usr/bin/* /usr/sbin/*
do
	nuevo="true"
	while read perm checksum filePath
	do
		if [[ $file == $filePath ]] 
		then 
			perm1=$(stat -c "%A" "$file")
			checksum1=$(md5sum "$file")
			checksum1=${checksum1/ *}
			[[ $perm1 != $perm ]] && echo "Los permisos de \"$file\" han cambiado, originales:\"$perm\" actuales:\"$perm1\"."
			[[ $checksum1 != $checksum ]] && echo "EL contenido de \"$file\" ha cambiado, checksum original:\"$checksum\" checksum actual:\"$checksum1\"."
			nuevo="false"
			break
		fi
	done < "$1"		
	[[ $nuevo == "true" ]] && echo "El fichero \"$file\" es nuevo."
done >> $LOG_FILE


while read perms checksum filePath
do
	[[ ! -f "$filePath" ]] && echo "El fichero \"$filePath\" ha sido eliminado."
done < "$1" >> $LOG_FILE




