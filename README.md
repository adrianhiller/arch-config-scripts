# arch-config-scripts
Arch Config Scripts


Um dieses Script zu benutzen, bitte wie folgt vorgehen:

1. Klonen des ConfigScriptes via wget:  
`pacman -S wget`  
`wget https://raw.githubusercontent.com/adrianhiller/arch-config-scripts/master/config.sh`

2. Ausführen des ConfigScriptes:  
`chmod +x config.sh`  
`./config.sh $hostname $grubinstallZiel $ersterBenutzer`  
Parameterbedeutung:  
`$hostname`: Rechnername  
`$grubinstallZiel`: Zielort der Grub-Installation, bspw: /dev/sda  
`$ersterBenutzer`: Nutzername des Hauptbenutzers (neben root), besitzt sudo-Rechte
