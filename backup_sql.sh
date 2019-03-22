#!/bin/bash

# Definindo parametros do MySQL
# - open file from list databases

echo "             Backup iniciado em: `date +%Y-%m-%d_%H:%M:%S`"
echo "-----------------------------------------------------------------------------"

dbarray=( $( cat /backup/parameter/databases.txt ) )

echo "  -- Definindo parametros do MySQL ..."
DB_NAME=''
DB_USER='root'
DB_PARAM='--add-drop-table --add-locks --extended-insert --single-transaction -quick'

# Definindo parametros do sistema
MYSQLDUMP=/usr/bin/mysqldump
BACKUP_DIR=/backup/mysql

echo "  -- Definindo parametros do sistema ..."
DATE=`date +%Y-%m-%d`

for DB_NAME in "${dbarray[@]}"
do
    echo "--> $DB_NAME ...."
    BACKUP_NAME=$DB_NAME-$DATE.sql
    BACKUP_TAR=$DB_NAME-$DATE.tar

    #Gerando arquivo sql
    echo "  -- Gerando Backup da base de dados $DB_NAME em $BACKUP_DIR/$BACKUP_NAME ..."
    $MYSQLDUMP $DB_NAME $DB_PARAM -u $DB_USER  > $BACKUP_DIR/$BACKUP_NAME

    # Compactando arquivo em tar
    echo "  -- Compactando arquivo em tar ..."
    tar -cvf  $BACKUP_DIR/$BACKUP_TAR -C $BACKUP_DIR $BACKUP_NAME


    # Excluindo arquivos desnecessarios
    echo "  -- Excluindo arquivos desnecessarios ..."
    rm -rf $BACKUP_DIR/$BACKUP_NAME

    echo ""
done

echo "Backup do MySQL executado"

# Backup da tabela de usuarios e permições
$MYSQLDUMP --user=$DB_USER --database mysql --tables db user > $BACKUP_DIR/bkp_users-$DATE.sql
tar -cvf  $BACKUP_DIR/bkp_users-$DATE.tar -C $BACKUP_DIR bkp_users-$DATE.sql
rm -rf $BACKUP_DIR/bkp_users-$DATE.sql

# Excluindo backups antigos
echo " -- Excluindo backups com mais de 30 dias ..."
find $BACKUP_DIR/* -mtime +30 -delete


echo "             Backup terminado em: `date +%Y-%m-%d_%H:%M:%S`"
echo "-----------------------------------------------------------------------------"



