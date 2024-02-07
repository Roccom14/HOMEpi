# Utiliser l'image slab42/bind9.18 comme base
FROM slab42/bind9.18

# Installer les dépendances nécessaires pour CUPS (Common UNIX Printing System), Webmin, Avahi et>
RUN apt-get update && \
    apt-get install -y cups webmin avahi-daemon cups-daemon && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Exposer les ports nécessaires
EXPOSE 631 10000

# Copier le fichier cupsd.conf personnalisé dans le conteneur
COPY cupsd.conf /etc/cups/cupsd.conf

# Copier le fichier d'entrée personnalisé dans le conteneur
COPY entrypoint.sh /entrypoint.sh

# Donner les permissions d'exécution au script d'entrée
RUN chmod +x /entrypoint.sh

# Lancer les services lors du démarrage du conteneur
CMD ["/entrypoint.sh"]