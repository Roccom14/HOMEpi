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
    ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook_install_pi1.yml
}

# Fonction pour effectuer l'action 2
action2() {
    ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook_install_pi2.yml
}

# Fonction pour effectuer l'action 3
action3() {
    ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook_install_pi3.yml
}

# Fonction pour effectuer l'action 4
action4() {
    ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook_update.yml
}

# Fonction pour effectuer l'action 5
action5() {
    ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook_cups.yml
}

# Fonction pour effectuer l'action 6
action6() {
    ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook_nas.yml
}

# Fonction pour effectuer l'action 7
action7() {
    ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook_rsync.yml
}

# Fonction pour effectuer l'action 8
action8() {
    ansible-playbook -i ./ansible/inventory.yml ./ansible/playbook_docker.yml
}

# Fonction pour afficher le menu
afficher_menu() {
    echo "Menu :"
    echo
    echo "1. Installer Pi1"
    echo "2. Installer Pi2"
    echo "3. Installer Pi3"
    echo "4. Mettre à jour tout les Raspberry Pi"
    echo "5. Mettre en place CUPS"
    echo "6. Mettre en place le NAS"
    echo "7. Mettre en place Rsync"
    echo "8. Mettre en plce Docker"
    echo -e "${RED}9. Quitter${CO}"
}

# Boucle principale
while true; do
    echo
    afficher_menu
    echo
    read -p "Choisissez une option (1-9) : " choix
    echo

    case $choix in
        1) action1 ;;
        2) action2 ;;
        3) action3 ;;
        4) action4 ;;
        5) action5 ;;
        6) action6 ;;
        7) action7 ;;
        8) action8 ;;
        9) echo -e "${ITALIC}Au revoir !${CO}"; echo ; exit ;;
        *) echo -e "${RED}Option invalide, veuillez choisir une option valide (1-9).${CO}";;
    esac
done