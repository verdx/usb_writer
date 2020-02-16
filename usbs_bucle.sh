#! /bin/bash

CONTINUE=true
FILES_DIR=""
while [ ! -d "$FILES_DIR" ];
do
    echo "Introduce la direccion de la carpeta con los archivos a copiar"
    read FILES_DIR
done
echo "Se copiarán todos los archivos en la carpeta $FILES_DIR a cada usb"
while $CONTINUE;
do
    
    BEFORE=$( find /dev/sd* -printf '%p\n' )
    echo "Introduce el pen y pulsa cualquier RET"
    read RANDOM
    sleep 2
    AFTER=$( find /dev/sd* -printf '%p\n' )
    USBS=$( diff --suppress-common-lines <(echo "$AFTER") <(echo "$BEFORE") | grep "< /dev/sd**" )
    TEMP=""
    for WORD in $( echo $USBS )
    do
	if [[ "$WORD" =~ /dev/sd** ]];
	then
	    TEMP="$TEMP $WORD"
	fi
    done
    USBS=$TEMP
    
    # CHECK THE DIRECTORY USED FOR MOUNTING
    # THE USB EXISTS AND IS NOT MOUNTED
    if [ -d /mnt/temp_usbs_writer ];
    then
        if mount | grep /mnt/temp_usbs_writer > /dev/null;
        then
	    umount /mnt/temp_usbs_writer > /dev/null
        fi
    else
        mkdir /mnt/temp_usbs_writer > /dev/null
    fi

    echo $USBS
    CONTINUE=false
done
