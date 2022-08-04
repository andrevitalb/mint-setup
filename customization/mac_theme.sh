apt install plank

mkdir -p ~/Documents/system/themes/whitesur
cd ~/Documents/system/themes/whitesur
git clone git@github.com:vinceliuice/WhiteSur-gtk-theme
git clone git@github.com:vinceliuice/WhiteSur-cursors
git clone git@github.com:vinceliuice/WhiteSur-icon-theme

WhiteSur-gtk-theme/install.sh

cp -r WhiteSur-gtk-theme/src/other/plank/* ~/.local/share/plank/themes

WhiteSur-icon-theme/install.sh
WhiteSur-cursors/install.sh
