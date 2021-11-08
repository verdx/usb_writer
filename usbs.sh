#! /bin/bash

umount /run/media/verdx/pen
mounted=false
if [ -e /dev/sdf ];  
then
    mount -v /dev/sdf /run/media/verdx/pen
    sdf_mounted=$?
    if [ $sdf_mounted -eq 0 ];
    then
	echo "mounted sdf1"
	mounted=true
    fi
else
    if [ -e /dev/sdg1 ];
    then
	mount -v /dev/sdg1 /run/media/verdx/pen
	sdg_mounted=$?
	echo "mounted sdg1"
	if [ $sdg_mounted -eq 0 ];
	then
	    echo "mounted sdg1"
	    mounted=true
	fi
    fi
fi
if $mounted;
then
    cp -r copy_files/* /run/media/verdx/pen/
    copied=$?
    if [ $copied -eq 0 ];
    then
	echo "copied"
    fi
    umount /run/media/verdx/pen/
    unmounted=$?
    if [ $unmounted -eq 0 ];
    then
	echo "unmounted"
    fi
    ls /run/media/verdx/pen
else
	echo "error"
fi   

