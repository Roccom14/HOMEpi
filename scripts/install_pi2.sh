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

# Installation des programmes spécifiques au pi2
sudo apt -y install rsync ansible

# Redémarrage du système pour appliquer les paramètres
sudo reboot now