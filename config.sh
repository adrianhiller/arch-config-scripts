pacman -S git
cd /tmp
git clone https://github.com/adrianhiller/arch-config-scripts
cd arch-config-scripts
chmod +x *.sh
./install.sh $1 $2 $3
./reboot.sh $3
