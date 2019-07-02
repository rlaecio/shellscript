#!/bin/sh
inicio=`date +%Y-%m-%d-%H.%M`
echo "---------------------------------------------------"
echo "- iniciando o backup do home em" $inicio

VERIFICA=$(df -h | awk '{ print $1}' | grep /dev/sdc1)

if [ $VERIFICA = /dev/sdc1 ]; then echo "Unidade ok..."

else
    echo "Unidade ainda não montada, remontando-a ..."
    mount /dev/sdc1 /Backup
fi

DATA=`date +%w`
horas=`date | cut -d" " -f4 | cut -d: -f1`

backup(){
        if [ $DATA = 1 ] ; then 
            echo "Segunda ..."
            time rsync -vhr /mnt/Magistech/Magistech/  /Backup/segunda-feira/            
        elif [ $DATA = 2 ] ; then 
            echo "Terça-feira ..."
            time rsync -vhr /mnt/Magistech/Magistech/  /Backup/terca-feira/
        elif [ $DATA = 3 ] ; then 
            echo "Quarta-feira ..."
            time rsync -vhr /mnt/Magistech/Magistech/  /Backup/quarta-feira/
        elif [ $DATA = 4 ] ; then
            echo "Quinta-feira ..."
            time rsync -vhr /mnt/Magistech/Magistech/  /Backup/quinta-feira/
        elif [ $DATA = 5 ] ; then 
            echo "Sexta-feira ..."
            time rsync -vhr /mnt/Magistech/Magistech/  /Backup/sexta-feira/
        elif [ $DATA = 6 ] ; then 
            echo "Sabado ..."
            time rsync -vhr /mnt/Magistech/Magistech/  /Backup/sabado/
        else echo fimdesemana
        fi
}

if (("$horas" >= "06")) && (("$horas" <= "12"))
then
	echo -e "Bom dia!"
    backup
elif (("$horas" > "12")) && (("$horas" < "18"))
then
	echo -e "Boa tarde!"
    backup
else
	echo -e "Boa noite!"
    backup
    rsync -vhr /home/  /Backup/home
fi


final=`date +%Y-%m-%d-%H.%M`
echo "---------------------------------------------------"
echo "- terminado o backup do home em" $final




