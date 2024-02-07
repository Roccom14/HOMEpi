#!/bin/bash

# Génération des locale en français suisse
sudo locale-gen fr_CH.UTF-8
sudo localectl set-locale LANG=fr_CH.UTF-8
export LANGUAGE=fr_CH.UTF-8
export LC_ALL=fr_CH.UTF-8
export LANG=fr_CH.UTF-8
export LC_CTYPE=fr_CH.UTF-8

# Mise à jour du système
sudo apt -y update && sudo apt -y full-upgrade

# Mise à jour du firmware
sudo rpi-update -y

# Installation des programmes spécifiques au pi3
sudo apt -y install certbot ca-certificates curl ansible

## Installation de Docker
# Ajout de la clé GPG officielle de Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Configuration du repository de Docker
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt -y update

# Installation des derniers paquets de Docker
sudo apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Redémarrage du système pour appliquer les paramètres
sudo reboot now