# Fix dual boot clock
timedatectl set-local-rtc 1 --adjust-system-clock

# Disable suspend on lid close
sudo nano /etc/systemd/logind.conf
# Change #HandleLidSwitch=suspend to HandleLidSwitch=ignore
systemctl restart systemd-logind

# Fix docker commands with no permissions
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
# Run groups and confirm docker is listed
groups