#!/bin/bash

# Démarrer les services CUPS et Webmin
service cups start
service webmin start

# Installer le client Apache
apt-get update
apt-get install -y apache2 apache2-utils

# Changer le mot de passe de Webmin
/usr/share/webmin/changepass.pl /etc/webmin root password

# Créer le répertoire htdocs s'il n'existe pas déjà
mkdir -p /var/www/html

# Modifier le fichier de configuration d'Apache pour inclure le répertoire racine correct
sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html|' /etc/apache2/apache2.conf

# Ajouter la directive ServerName dans le fichier de configuration d'Apache
echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Redémarrer Apache pour appliquer les changements
service apache2 restart

# Garder le conteneur en cours d'exécution
tail -f /dev/null