#!/bin/bash

# Montage du disque
sudo mount /dev/sda1

# Ajout du montage automatique au démarrage
echo '/dev/sda1 /mnt/sda1/ ext4 defaults,noatime 0 1' | sudo tee -a /etc/fstab

# Création des dossiers
sudo mkdir /mnt/sda1/backups
sudo mkdir /mnt/sda1/shared
sudo mkdir /mnt/sda1/shared/nas1-tpi
sudo mkdir /mnt/sda1/shared/nas2-tpi
sudo mkdir /mnt/sda1/TimeMachine

# Configuration de Samba
sudo tee -a /etc/samba/smb.conf > /dev/null <<EOL
[shared]
path=/mnt/sda1/shared
writeable=yes
create mask=0770
directory mask=0770
public=no

[backups]
path=/mnt/sda1/backups
writeable=yes
create mask=0770
directory mask=0770
public=no

[TimeMachine]
comment = Time Machine Backup
path = /mnt/sda1/TimeMachine
browseable = yes
writeable = yes
guest ok = no
create mask = 0770
directory mask = 0770
vfs objects = catia fruit streams_xattr
fruit:aapl = yes
fruit:time machine = yes
EOL

# Redémarrage de Samba
sudo systemctl restart smbd

# Création des utilisateurs
sudo adduser nas1-tpi
sudo adduser nas2-tpi
sudo adduser mac-tpi
sudo adduser win-tpi
sudo adduser homepi
sudo usermod -aG sudo homepi

# Ajout de mot de passe aux utilisateurs Samba
sudo smbpasswd -a nas1-tpi
sudo smbpasswd -a nas2-tpi
sudo smbpasswd -a mac-tpi
sudo smbpasswd -a win-tpi

# Ajout des utilisateurs dans les groupes
sudo adduser homepi nas1-tpi
sudo adduser homepi nas2-tpi
sudo adduser homepi mac-tpi
sudo adduser homepi win-tpi
sudo adduser homepi backups
sudo adduser homepi shared
sudo adduser homepi timemachine
sudo adduser nas1-tpi homepi
sudo adduser nas2-tpi homepi
sudo adduser mac-tpi homepi
sudo adduser win-tpi homepi
sudo adduser nas1-tpi shared
sudo adduser nas2-tpi shared
sudo adduser mac-tpi timemachine
sudo adduser win-tpi backups
sudo adduser "$(whoami)" homepi

# Ajout des droits aux dossiers
sudo chmod -R 770 /mnt/sda1
sudo chown -R homepi /mnt/sda1
sudo chown -R :homepi /mnt/sda1
sudo chown -R :backups /mnt/sda1/backups
sudo chown -R :shared /mnt/sda1/shared
sudo chown -R :nas1-tpi /mnt/sda1/shared/nas1-tpi
sudo chown -R :nas2-tpi /mnt/sda1/shared/nas2-tpi
sudo chown -R :timemachine /mnt/sda1/TimeMachine

# Redémarrage de Samba
sudo systemctl restart smbd