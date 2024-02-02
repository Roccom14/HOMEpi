#!/bin/bash

# Ajouter le script en cron 0 * * * * /home/pi2/rsync_hourly.sh

# Définition des paramètres
source="homepi@pi1.local:/mnt/sda1/"
destination="/mnt/sda1/"

# Exécution de la sauvegarde avec rsync
sudo rsync -rvzu $source $destination