#!/bin/bash

resposta=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost)
if [ $resposta -ne 200 ]
then
mail -s "Problema no Servidor" rlaecio@hotmail.com << msn
"Houve um problema no servidor e os usuario pararam de ter acesso ao conteudo web."
msn
systemctl start httpd
fi
