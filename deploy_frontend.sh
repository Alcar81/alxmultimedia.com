#!/bin/bash

# Variables
CONTAINER_NAME="front_dev"
FRONTEND_DIR="/home/dev.alxmultimedia.com/public_html/build"

# Vérifier que FRONTEND_DIR est défini
if [ -z "$FRONTEND_DIR" ]; then
  echo "Erreur: FRONTEND_DIR n'est pas défini."
  exit 1
fi

# Étape 1 : Construire le build dans le conteneur
docker exec $CONTAINER_NAME npm run build || { echo "Erreur: Échec du build du frontend."; exit 1; }

# Étape 2 : Supprimer l'ancien build sur le serveur
rm -rf $FRONTEND_DIR || { echo "Erreur: Impossible de supprimer l'ancien build."; exit 1; }

# Étape 3 : Copier le nouveau build du conteneur vers le serveur
docker cp $CONTAINER_NAME:/app/build $FRONTEND_DIR || { echo "Erreur: Échec de la copie du nouveau build."; exit 1; }

# Étape 4 : Redémarrer OpenLiteSpeed pour appliquer les modifications
sudo service lsws restart || { echo "Erreur: Impossible de redémarrer OpenLiteSpeed."; exit 1; }

# Confirmation de succès
echo "Déploiement du frontend terminé avec succès."
