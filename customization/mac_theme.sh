apt install plank

mkdir -p ~/Documents/System/Themes/WhiteSur
cd ~/Documents/System/Themes/WhiteSur
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme
git clone https://github.com/vinceliuice/WhiteSur-cursors
git clone https://github.com/vinceliuice/WhiteSur-icon-theme

cd WhiteSur-gtk-theme
./install.sh

cp -R src/other/plank/* ~/.local/share/plank/themes

cd ../WhiteSur-icon-theme
./install.sh

cd ../WhiteSur-cursors
./install.sh