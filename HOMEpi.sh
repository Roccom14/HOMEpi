#!/bin/bash

# Couleur et style de police
CO='\033[0m'
RED='\033[0;31m'
ITALIC='\033[3m'
ITALIC_RED='\033[3;31m'

# Vérification admin
if [ "$EUID" -ne 0 ]; then
  echo
  echo -e "${ITALIC_RED}Ce script nécessite des droits administrateurs, exécutez-le avec sudo !${CO}"
  echo
  exit
fi

# Fonction pour effectuer l'action 1
action1() {
    ./scripts/install_pi1.sh
}

# Fonction pour effectuer l'action 2
action2() {
    ./scripts/install_pi2.sh
}

# Fonction pour effectuer l'action 3
action3() {
    ./scripts/install_pi3.sh
}

# Fonction pour effectuer l'action 4
action4() {
    
}

# Fonction pour effectuer l'action 5
action5() {
    
}

# Fonction pour effectuer l'action 6
action6() {
    
}

# Fonction pour afficher le menu
afficher_menu() {
    echo "Menu :"
    echo
    echo "1. Installer Pi1"
    echo "2. Installer Pi2"
    echo "3. Installer Pi3"
    echo "4. Configurer Pi1"
    echo "5. Configurer Pi2"
    echo "6. Configurer Pi3"
    echo -e "${RED}4. Quitter${CO}"
}

# Boucle principale
while true; do
    echo
    afficher_menu
    echo
    read -p "Choisissez une option (1-4) : " choix
    echo

    case $choix in
        1) action1 ;;
        2) action2 ;;
        3) action3 ;;
        4) action4 ;;
        5) action5 ;;
        6) action6 ;;
        7) echo -e "${ITALIC}Au revoir !${CO}"; echo ; exit ;;
        *) echo -e "${RED}Option invalide, veuillez choisir une option valide (1-4).${CO}";;
    esac
done