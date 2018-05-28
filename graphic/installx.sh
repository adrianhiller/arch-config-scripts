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
echo '#!/bin/sh' > /home/$1/.xinitrc
echo 'userresources=$HOME/.Xresources' >> /home/$1/.xinitrc
echo 'usermodmap=$HOME/.Xmodmap' >> /home/$1/.xinitrc
echo 'sysresources=/etc/X11/xinit/.Xresources' >> /home/$1/.xinitrc
echo 'sysmodmap=/etc/X11/xinit/.Xmodmap'  >> /home/$1/.xinitrc
chown $1:$1 /home/$1/.xinitrc
chmod 770 /home/$1/.xinitrc
echo "fertig"
