!/bin/bash

# Definindo parametros do PgSQL
# - open file from list databases

dbarray=( $( cat /backup/databases.txt ) )

echo "  -- Definindo parametros do PgSQL ..."
DB_NAME=''
DB_USER='postgres'
DB_PARAM='5432'

# Definindo parametros do sistema
SQLDUMP=/usr/bin/pg_dump
BACKUP_DIR=/backup/database/

echo "  -- Definindo parametros do sistema ..."
DATE=`date +%Y-%m-%d`

for DB_NAME in "${dbarray[@]}"
do
    echo "$DB_NAME"
    BACKUP_NAME=$DB_NAME-$DATE.sql
    BACKUP_TAR=$DB_NAME-$DATE.tar

    #Gerando arquivo sql
    echo "  -- Gerando Backup da base de dados $DB_NAME em $BACKUP_DIR/$BACKUP_NAME ..."
        
    $SQLDUMP -p $DB_PARAM -U $DB_USER -C -f $BACKUP_DIR/$BACKUP_NAME $DB_NAME
    # Compactando arquivo em tar
    echo "  -- Compactando arquivo em tar ..."
    tar -cjf $BACKUP_DIR/$BACKUP_TAR -C $BACKUP_DIR $BACKUP_NAME --remove-files



done
echo "Backup do PgSQL executado"


# Excluindo backups antigos
echo " -- Excluindo backups com mais de 30 dias ..."
find $BACKUP_DIR/* -mtime +30 -delete

