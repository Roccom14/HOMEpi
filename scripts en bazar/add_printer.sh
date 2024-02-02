#!/bin/bash

# Vérification si l'utilisateur a les droits d'administration
if [ "$(id -u)" != "0" ]; then
  echo "Ce script doit être exécuté en tant qu'administrateur (root)." >&2
  exit 1
fi

# Mise à jour CUPS
apt install -y cups

# Ajout de l'utilisateur au groupe lpadmin
usermod -aG lpadmin "$(whoami)"

# Redémarrage du service CUPS
service cups restart

# Recherche des imprimantes USB disponibles
usb_printers=$(lpinfo -v | grep -E 'usb://' | awk '{print $2}')

# Vérification si des imprimantes USB ont été détectées
if [ -z "$usb_printers" ]; then
  echo "Aucune imprimante USB détectée."
  exit 1
fi

# Choix de la première imprimante USB détectée
chosen_printer=$(echo "$usb_printers" | head -n 1)

# Demande à l'utilisateur du choix le nom de l'imprimante
echo "Imprimantes USB détectées :"
echo "$usb_printers"
read -p "Choisissez un nom pour l'imprimante: " printer_name

# Ajout de l'imprimante à CUPS
lpadmin -p "$printer_name" -E -v "$chosen_printer" -m everywhere

# Activation de l'imprimante
cupsenable "$printer_name"

# Configuration des options de l'imprimante
lpoptions -d "$printer_name"

# Redémarrage du service CUPS
service cups restart