#/bin/bash
#Exemplo yad
Saida=$(zenity --forms --imag blog-min.png --image-on-top \ 
    --title "Terminal Root" \
    --text "Exemplo <b>YAD</b> por <big><b>Terminal Roo</b></big>" \
    --field Nome 'Marcos' \
    --field Nascimento:DT 08/02/1989 \
    --field "Há quanto tempo usa <b>Linux</b>:NUM" '1!0..20!1' \
    --field "Sites preferidos:CB" 'Terminal Root!BR'Linux!Dicas-l!Viva o Linux!Outros' \
    --field "Vou passar a usar o yad:CHK" TRUE \
    --field "Vou ontinuar usando zenity:CHK")

echo $Saida