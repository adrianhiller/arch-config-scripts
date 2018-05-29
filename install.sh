#!/bin/bash

# Hostname setzen
echo "Setze Rechnername zu $1 ..."
echo $1 > /etc/hostname
echo "fertig"

# Lokaleinstellungen setzen
echo "Setze lokalen Standart zu de_DE.UTF-8 ..."
echo "de_DE.UTF-8" > /etc/locale.conf
echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "fertig"

# VConsole Keyboardlayout
echo "Setze Tastaturlayout zu de-latin1 ..."
echo "KEYMAP=de-latin1" > /etc/vconsole.conf
echo "fertig"

# Zeitzone
echo "Setze Zeitzone zu Berlin ..."
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
echo "fertig"

# Aktualisiere Pacman
echo "Aktualisiere Pacman Paketlisten ..."
pacman -Sy
echo "fertig"

# Kernel erzeugen
echo "Erzeuge Kernel ..."
mkinitcpio -p linux
echo "fertig"

# RootPasswd
echo "Setze Root-Passwort ..."
passwd1=$(dialog --stdout --title root-Passwort --passwordbox "Bitte gib das root-Passwort ein" 15 60)
passwd2=$(dialog --stdout --title root-Passwort --passwordbox "Bitte gib das root-Passwort erneut ein" 15 60)
echo -e "$passwd1\n$passwd2" | passwd
echo "fertig"

# Grub
echo "Installiere Bootloader auf $2 ..."
pacman -S grub
grub-mkconfig -o /boot/grub/grub.cfg
grub-install $2
echo "fertig"

# Sudo
echo "Installiere sudo ..."
pacman -S sudo
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "fertig"

# Benutzer
echo "Lege neuen Benutzer $3 an ..."
useradd -m -g users -s /bin/bash $3
gpasswd -a $3 wheel
echo "fertig"
echo "Setze Benutzer-Passwort für $3 ..."
passwd1=$(dialog ---stdout -title $3-Passwort --passwordbox "Bitte gib das $3-Passwort ein" 15 60)
passwd2=$(dialog --stdout --title $3-Passwort --passwordbox "Bitte gib das $3-Passwort erneut ein" 15 60)
echo -e "$passwd1\n$passwd2" | passwd $3
echo "fertig"

# BashRC für Root
echo "konfiguriere .bashrc für root ..."
echo "PS1='[\[\033[1;31m\]\u@\h\[\033[0m\] \W]\\$ '" >> /root/.bashrc
echo "pwd" >> /root/.bashrc

# BashRC für User
echo "konfiguriere .bashrc für $3 ..."
echo "PS1='\[\033[0;37m\]\A\[\033[0m\] [\u@\h: \W]\\$ '" >> /home/$3/.bashrc
echo "pwd" >> /home/$3/.bashrc

graphic=$(dialog --stdout --backtitle graphische Oberfläche --title "Bitte auswählen" --radiolist "Welche graphische Oberfläche soll ich installieren?" 16 60 5 \
	"i3" "installiere i3" on \
	"MATE" "installiere MATE" off \
	"Cinnamon" "installiere Cinnamon" off \
  "LXDE" "installiere LXDE" off \
  "Xfce" "installiere Xfce" off \
  "GNOME" "installiere GNOME" off \
  "ohne" "keine graphische Oberfläche installieren" off)

if [$graphic=="ohne"]
  then
    echo "Es wird keine graphische Oberfläche installiert"
  else
    ./graphic/installx.sh $3
  case "$graphic" in
  	"i3") ./graphic/i3.sh $3
  	"MATE") ./graphic/mate.sh $3
  	"Cinnamon") ./graphic/cinnamon.sh $3
    "LXDE") ./graphic/lxde.sh $3
    "Xfce") ./graphic/xfce.sh $3
    "GNOME") ./graphic/gnome.sh $3

  	*) echo "Das war wohl nix"

  esac
fi

# SSH
echo "Installiere SSH ..."
pacman -S openssh
systemctl enable sshd
echo "fertig"
