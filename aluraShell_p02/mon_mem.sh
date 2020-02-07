#!/bin/bash
memoria_total=$(free |grep -i mem | awk '{ print $2 }')
memoria_consumida=$(free |grep -i mem | awk '{ print $3 }')
relacao_memoria=$(bc <<< "scale=2;$memoria_consumida/$memoria_total *100" |awk -F. '{ print $1}')

if [ $relacao_memoria -gt 10 ]
then
	mail -s "Cosumo de memoria acima do limite" rlaecio@gmail.com <<msn
O consumo de memoria esta acima do limite especificados, atualmente o sonsumo e de: 
$(free -h |grep -i mem | awk '{ print $3}')
msn

fi
