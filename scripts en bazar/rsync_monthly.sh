#!/bin/bash

# Ajouter le script en cron 0 0 1 * * /home/pi2/rsync_monthly.sh

# Définition des paramètres
# source="pi1@pi1.local:/mnt/sda1/"
# destination="/mnt/sda1/"

# Exécution de la sauvegarde avec rsync
# sudo rsync -rvzu --delete $source $destination

mois=$(date +%B)
jour=$(date +%d-%m-%Y)
heure=$(date +%T)
userssh="rsync"
hostssh="pi1.local"
distant="/mnt/sda1/"
local="/mnt/sda1/sauvegardes_$mois/"
retention=$(date +%B --date='1 month ago')
 
# Transfert des fichiers
rsync -avz --stats --protect-args --delete-after -e ssh $userssh@$hostssh:$distant $local
 
# On supprime les sauvegardes suivant la rétention.
ssh $userssh@$hostssh rm -rf "/mnt/sda1/sauvegardes_$retention"