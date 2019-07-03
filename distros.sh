#!/bin/bash
while true;
	do
	distros=$(dialog --stdout --title "Escola sua sistro" --menu "Qual sua distro preferida" 0 0 0\
		1 "Debian"	\
		2 "Red Hat"	\
		3 "Gentoo"	\
		4 "Slackware"	\
		5 "Ubuntu"	\
		0 "Sair"	)

	[ $? -ne 0 ] && echo "Cancelou ou Carregou ESC." && break

	case "$distros" in
		1) dialog --stdout --msgbox "Essa e a melhor distro! :)" 5 30 ; break;;
		2) dialog --title 'Red Hat' --infobox 'Ela agora é ENTERPRISE. :(' 5 65 ; break ;;
		3) dialog --title 'Gentoo' --msgbox 'Voce é PSICOPATA!' 5 65 ; break ;;
		4) dialog --title 'Slackware' --yesno 'Voce é ATEU?' 5 65;

		
		if [ $? = 0 ]; then
			dialog --title 'Slackware Ateu' --infobox '\nSabia!' 0 0;
		else
			dialog --title 'Slackware Nao Ateu?' --infobox '\nAmarelou.' 0 0;
		fi

		break ;;

		5) dialog --title 'Ubuntu' --timebox '\nVou gravar a hora que voce escolheu esse absurdo.' 0 0; break ;;
		0) echo "Voce escolheu Sair" ; break ;;
	esac
done
