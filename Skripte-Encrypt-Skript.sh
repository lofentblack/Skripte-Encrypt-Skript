#!/bin/bash

# Gucken ob der Benutzer root ist
if [ "$(id -u)" != "0" ]; then
  echo $(tput setaf 1)Bitte wechseln Sie zu einem Admin/Root Benutzer$(tput sgr0)
  exit 1;
fi

#Name vom Script
SCRIPTNAME="Lock Skript"
LOCK=".lock-lock"

content=$(wget https://raw.githubusercontent.com/lofentblack/Skripte-Encrypt-Skript/refs/heads/main/version.txt -q -O -)
Version=$content

checkUpdate() {
content=$(wget https://raw.githubusercontent.com/lofentblack/Skripte-Encrypt-Skript/refs/heads/main/version.txt -q -O -)
version=$content

# Eingabedatei
AnzahlZeilen=$(wc -l ${LOCK} | awk ' // { print $1; } ')
for LaufZeile in $(seq 1 ${AnzahlZeilen})
 do
  Zeile=$(sed -n "${LaufZeile}p" ${LOCK})
  Test=${Zeile}
	if [[ "$Test" == *"version"* ]]; then
		if [[ "$Test" == *"version"* ]]; then
		  var1=$(sed 's/version=//' <<< "$Test")
		  var2=$(sed 's/^.//;s/.$//' <<< "$var1")
		  SkriptVersion=$var2
		fi
	fi
done

if ! [[ $version == $SkriptVersion ]]; then
	sudo apt-get install wget -y
	clear
	clear

	echo $(tput setaf 3)"Update von Version "$SkriptVersion" zu "$version"."
	echo "$(tput sgr0)"
	wget https://raw.githubusercontent.com/lofentblack/Skripte-Encrypt-Skript/refs/heads/main/Skripte-Encrypt-Skript.sh -O Skripte-Encrypt-Skript-new.sh
	rm $LOCK
	chmod 775 Skripte-Encrypt-Skript.sh
	rm Skripte-Encrypt-Skript.sh
	mv Skripte-Encrypt-Skript.x Skripte-Encrypt-Skript.x

fi
}

checkUpdate

lofentblackDEScript() {

rot="$(tput setaf 1)"
gruen="$(tput setaf 2)"
gelb="$(tput setaf 3)"
dunkelblau="$(tput setaf 4)"
lila="$(tput setaf 5)"
turkies="$(tput setaf 6)"

# Notwendige Packete
installations_packete() {

apt-get install sudo -y
sudo apt-get update -y
sudo apt-get install screen -y

screen=instalations_packete_lb.de_script
screen -Sdm $screen apt-get install figlet -y && screen -Sdm $screen sudo apt-get upgrade -y && screen -Sdm $screen sudo apt-get shc -y && screen -Sdm $screen sudo apt-get install shc -y

sleep 10

echo "Notwendige Pakete Installiert"

sleep 1

clear
clear
echo $gruen"Bitte starte das Skript neu!"
echo "$(tput sgr0)"

}

# Script Verzeichniss
	reldir=`dirname $0`
	cd $reldir
	SCRIPTPATH=`pwd`

clear
clear

 if [ -s $SCRIPTPATH/.lock-lock ]; then
	echo "$(tput setaf 2)"
	figlet -f slant -c $SCRIPTNAME
	echo $rot
	echo "Mit dem Ausführen Akzeptieren Sie die Lizenz."
	echo "$(tput sgr0)"

	echo "Bitte gebe Sie den Namen der Datei ein die Sie Verschlüsseln möchten!"
	read -p "" DATEI

	if [ -s ./$DATEI ]; then
		shc -r -f $DATEI
			clear
			clear
			echo "$(tput setaf 2)"
			figlet -f slant -c $SCRIPTNAME
			echo $rot
			echo "Mit dem Ausführen Akzeptieren Sie die Lizenz."
			echo "$(tput sgr0)"
			echo "Bitte gebe Sie den Namen der Datei ein den Sie Verschlüsseln möchten!"
			echo "$DATEI"
		if [ -s $DATEI.x.c ]; then
			rm -r $DATEI.x.c
			echo "Abgeschlossen!"
		else
			echo "Ein Fehler ist Aufgetreten die Datei hat möglicherweise kein Anfang FehlerCode(02)"
		fi
	else
		echo "Die Datei ist nicht in dem Verzeichnis oder Falsch Geschrieben. FehlerCode(01)"
	fi


	elif ! [ -s $SCRIPTPATH/$LOCK ]; then
    > $LOCK
    echo -e 'int=true\nversion="'$Version'"\n\n#Mit dieser Datei erkennt das Skript das alle notwendigen Pakete installiert worden sind.' > $SCRIPTPATH/$LOCK
    installations_packete
fi

}
lofentblackDEScript
