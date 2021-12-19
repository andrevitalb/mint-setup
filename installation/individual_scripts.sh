#   Basic stuff
apt install \
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
apt install deluge \
    locate \
    xbindkeys xautomation \

# Brave browser
curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
apt update
install brave-browser

# Node JS
curl -sL https://deb.nodesource.com/setup_16.x | -E bash -
install nodejs
# NPM basic packages
npm i -g npm-check-updates yarn

# Python 3.10
apt install software-properties-common
add-apt-repository ppa:deadsnakes/ppa
apt update
apt install python3.10
# Custom .bashrc file contains alias python for running python3.10

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install docker-ce docker-ce-cli containerd.io

# PostgreSQL
sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt update
apt install postgresql


# Snap installations
snap install spotify
snap install discord
snap install vlc
snap install notion-snap
snap install alacritty
snap install terraform --candidate
snap install postman