echo 'Das System wurde eingerichtet. Bitte starte den Rechner neu.'
ip=$(hostname -i)
echo 'Nach dem Neustart kannst du dich lokal oder über ssh anmelden.'
echo "SSH: ssh $3@$ip"
echo " "
echo "Bitte vergiss nicht, dir eine graphische Oberfläche zu installieren und sie in der .xinitrc zu verknüpfen."
echo " "
read -rsp $'Drücke irgendeine Taste um den Rechner neu zu starten ...\n' -n1 key
exit
reboot

