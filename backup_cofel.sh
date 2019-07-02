#!/bin/sh
inicio=`date +%Y-%m-%d-%H.%M`
echo "---------------------------------------------------"
echo "- iniciando o backup do home em" $inicio

VERIFICA=$(df -h | awk '{ print $1}' | grep /dev/sdd1)

if [ $VERIFICA = /dev/sdd1 ]; then echo "Unidade ok..."

else
    echo "Unidade ainda não montada, remontando-a ..."
    mount -t ntfs-3g /dev/sdd1 /Backup-ext
fi

DATA=`date +%w`
backup(){
        if [ $DATA = 1 ] ; then 
            echo "Segunda ..."
            rsync -vhr /home  /Backup-ext/segunda
        elif [ $DATA = 2 ] ; then 
            rsync -vhr /home  /Backup-ext/terca
        elif [ $DATA = 3 ] ; then 
            rsync -vhr /home  /Backup-ext/quarta
        elif [ $DATA = 4 ] ; then
            rsync -vhr /home  /Backup-ext/quinta
        elif [ $DATA = 5 ] ; then 
            rsync -vhr /home  /Backup-ext/sexta
        elif [ $DATA = 6 ] ; then 
            rsync -vhr /home  /Backup-ext/sabado
        else echo fimdesemana
        fi
}
backup

final=`date +%Y-%m-%d-%H.%M`
echo "---------------------------------------------------"
echo "- terminado o backup do home em" $final




