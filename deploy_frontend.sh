#!/bin/bash

# Variables
CONTAINER_NAME="front_prod"
FRONTEND_DIR="/home/alxmultimedia.com/public_html/build"

# Étape 1: Construire le build dans le conteneur
docker exec $CONTAINER_NAME npm run build

# Étape 2: Supprimer l'ancien build sur le serveur
rm -rf $FRONTEND_DIR

# Étape 3: Copier le nouveau build du conteneur vers le serveur
docker cp $CONTAINER_NAME:/app/build $FRONTEND_DIR

# Étape 4: Redémarrer OpenLiteSpeed pour appliquer les modifications
sudo service lsws restart

echo "Déploiement du frontend terminé avec succès."
