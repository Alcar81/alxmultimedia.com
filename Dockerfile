# Étape de construction
FROM node:lts-alpine as build

# Répertoire de travail pour la phase de build
WORKDIR /app

# Copier les fichiers de configuration
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier les fichiers du projet
COPY . .

# Générer les fichiers de production
RUN npm run build

# Étape de déploiement
FROM nginx:alpine

# Copier le build dans le répertoire de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Commande de démarrage de Nginx
CMD ["nginx", "-g", "daemon off;"]
