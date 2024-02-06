#!/bin/bash

# Définition des valeurs demandées pour OpenSSL
COUNTRY="CH"                    # Code Pays
STATE="Vaud"                    # Etat ou province
CITY="Lausanne"                 # Ville
ORGANIZATION="EPFL"             # Organisation
ORG_UNIT="ENAC-IT"              # Unité d'organisation
COMMON_NAME="pi3.local"         # Adresse IP ou FQDN
EMAIL="rocco.ronzano@epfl.ch"   # Email

# Création du certificat SSL avec les valeurs définies
sudo openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout server.key -out server.crt -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$ORG_UNIT/CN=$COMMON_NAME/emailAddress=$EMAIL"
