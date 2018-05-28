#!/bin/bash

# Hostname setzen
echo "Setze Rechnername zu $1 ..."
echo $1 > /etc/hostname
echo "fertig"

# Lokaleinstellungen setzen
echo "Setze lokalen Standart zu de_DE.UTF-8 ..."
echo "de_DE.UTF-8" > /etc/locale.conf
echo echo "de_DE.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "fertig"

# VConsole Keyboardlayout
echo "Setze Tastaturlayout zu de-latin1 ..."
echo "KEYMAP=de-latin1" > /etc/vconsole.conf
echo "FONT=lat9w16" >> /etc/vconsole.conf
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
echo "Bitte Root-Passwort setzen"
passwd
echo "fertig"

# Grub
echo "Installiere Bootloader auf $2 ..."
pacman -S grub
grub-mkconfig -o /boot/grub/grub.cfg
grub-install $2
echo "fertig"

# Sudo
echo "Installiere sudo" ...
pacman -S sudo
%wheel ALL=(ALL) ALL >> /etc/sudoers
echo "fertig"

# Benutzer
echo "Lege neuen Benutzer $3 an ..."
useradd -m -g users -g wheel -s /bin/bash $3
echo "fertig"
echo "Setze Benutzer-Passwort für $3 ..."
echo "Bitte Benutzer-Passwort für $3 eingeben"
passwd $3
echo "fertig"

# Xorg
echo "Installiere X-Server ..."
pacman -S xorg-server xorg-xinit xorg-drivers
echo "Setze Tastaurlayout auf de, pc105, nodeadkeys ..."
echo 'Selection "InputClass"' > /etc/X11/xorg.conf.d/20-keyboard
echo 'Identifier "keyboard"' >> /etc/X11/xorg.conf.d/20-keyboard
echo 'MatchIsKeyboard "yes"' >> /etc/X11/xorg.conf.d/20-keyboard
echo 'Option "XkbLayout" "de"' >> /etc/X11/xorg.conf.d/20-keyboard
echo 'Option "XkbModel" "pc105"' >> /etc/X11/xorg.conf.d/20-keyboard
echo 'Option "XkbVariant" "nodeadkeys"' >> /etc/X11/xorg.conf.d/20-keyboard
echo 'EndSection' >> /etc/X11/xorg.conf.d/20-keyboard
echo "fertig"

# XInitRC
echo "Lege .xinitrc an ..."
echo '#!/bin/sh' > /home/$3/.bashrc
echo 'userresources=$HOME/.Xresources' >> /home/$3/.bashrc
echo 'usermodmap=$HOME/.Xmodmap' >> /home/$3/.bashrc
echo 'sysresources=/etc/X11/xinit/.Xresources' >> /home/$3/.bashrc
echo 'sysmodmap=/etc/X11/xinit/.Xmodmap'  >> /home/$3/.bashrc
chown $3:$3 /home/$3/.bashrc
chmod 770 /home/$3/.bashrc
echo "fertig"

# SSH
echo "Installiere SSH ..."
pacman -S openssh
echo "fertig"
