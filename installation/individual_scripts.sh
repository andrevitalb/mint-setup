#   Basic stuff
apt install -y \
    curl \
    apt-transport-https \
    git \
    ca-certificates \
    gnupg \
    lsb-release

# Enabling/installing snapd
rm /etc/apt/preferences.d/nosnap.pref
apt install snapd

# Simple apt installs
apt install -y \
    deluge \
    locate \
    xbindkeys xautomation

# Brave browser
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
apt install brave-browser

# Node JS
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
apt install nodejs
# NPM basic packages
npm i -g npm-check-updates yarn

# Python 3.10
apt install python3 python-is-python3

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io

# PostgreSQL
apt update
apt install postgresql postgresql-contrib

# Manual PostgreSQL config
# sudo -u postgres psql
# ALTER USER postgres WITH PASSWORD 'password';
# \q
# exit

# PgAdmin4
curl  -fsSL https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/pgadmin.gpg
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'
apt update -y
apt install -y pgadmin4-desktop

# Inkdrop
wget https://api.inkdrop.app/download/linux/deb -O /tmp/inkdrop.deb && sudo dpkg -i /tmp/inkdrop.deb && rm /tmp/inkdrop.deb

# Alacritty
mkdir -p ~/Documents/github
cd ~/Documents/github
git clone git@github.com:alacritty/alacritty
cd alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable
apt install -y \
    cmake \
    pkg-config \
    libfreetype6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev
cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin
sudo cp target/release/alacritty /usr/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

## Making Alacritty default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
### Alacritty (auto mode) should be selected
sudo update-alternatives --config x-terminal-emulator

## Adding dynamic titles to Alacritty title bar
nano /etc/bash.bashrc
### Uncomment code block starting with case "$TERM"
### Add alacritty* to the line containing xterm*|rxvt*

# Snap installations
snap install code --classic
snap install spotify
snap install discord
snap install vlc
snap install notion-snap
snap install terraform --classic
snap install zoom-client
snap install teams-for-linux
snap install todoist
