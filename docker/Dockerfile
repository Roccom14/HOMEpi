FROM debian:stable-slim

# Installation des mises à jour, des dépendances de Webmin, des outils réseau et de CUPS
RUN apt -y update && apt -y full-upgrade
RUN apt -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python-is-python3 wget unzip shared-mime-info net-tools cups apache2-utils curl

# Suppression des listes de paquets
RUN rm -rf /var/lib/apt/lists/*

# Installation du module Perl DateTime
RUN cpan DateTime

# Téléchargement et installation de Webmin
RUN curl -o setup-repos.sh https://raw.githubusercontent.com/webmin/webmin/master/setup-repos.sh && yes | sh setup-repos.sh && apy -y update && apt -y install webmin --install-recommends

# Exposer les ports nécessaires
EXPOSE 631 10000

# Copier le fichier cupsd.conf personnalisé dans le conteneur
COPY ../conf/cupsd.conf /etc/cups/cupsd.conf

# Copier le fichier d'entrée personnalisé dans le conteneur
COPY entrypoint.sh /entrypoint.sh

# Donner les permissions d'exécution au script d'entrée
RUN chmod +x /entrypoint.sh

# Lancer les services lors du démarrage du conteneur
CMD ["/bin/bash", "-c", "/entrypoint.sh && tail -f /dev/null"]