#!/bin/bash

home_dir=/home/roque.souza/

cd $home_dir

if [ ! -d backup ]
then
    mkdir backup
fi

mysqldump -uroot -plouvor01 $1 > $home_dir/backup/$1.sql
if [ $? -eq 0 ]
then
    echo "Backup realizado com sucesso"
else
    echo "Houve problema com o backup"
fi