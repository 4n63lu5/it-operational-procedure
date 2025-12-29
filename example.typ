#import "lib.typ": *

#show: procedure.with(
  title: "Installation et Configuration de Nginx",
  doc-number: "PROC-001",
  version: "1.2.0",
  date: "29/12/2024",
  author: "Équipe Infrastructure",
  tlp-level: "green",
  revisions: (
    (version: "1.0.0", date: "15/10/2024", author: "J. Dupont", description: "Création initiale"),
    (version: "1.1.0", date: "20/11/2024", author: "M. Martin", description: "Ajout de la section SSL"),
    (version: "1.2.0", date: "29/12/2024", author: "J. Dupont", description: "Mise à jour des commandes"),
  ),
  approvers: (
    (role: "Rédacteur", name: "Jean Dupont", signature: ""),
    (role: "Validateur Technique", name: "Marie Martin", signature: ""),
    (role: "Approbateur", name: "Pierre Durand", signature: ""),
  )
)

= Introduction

Ce document décrit la procédure d'installation et de configuration du serveur web Nginx sur un système Linux Ubuntu 22.04 LTS.

#info[
Cette procédure s'applique aux environnements de production et de préproduction. Pour les environnements de développement, certaines étapes peuvent être simplifiées.
]

= Prérequis

Avant de commencer, assurez-vous que :

- Vous avez un accès root ou sudo au serveur
- Le serveur est connecté à Internet
- Les ports 80 et 443 sont disponibles

#warning[
Cette procédure nécessite des privilèges administrateur. Assurez-vous d'avoir les autorisations nécessaires avant de continuer.
]

= Installation de Nginx

== Mise à jour du système

Commencez par mettre à jour la liste des paquets disponibles :

#terminal[
  \$ sudo apt update
  \$ sudo apt upgrade -y
]

== Installation du paquet Nginx

Installez Nginx avec la commande suivante :

#terminal[
  \$ sudo apt install nginx -y
]

== Vérification de l'installation

Vérifiez que Nginx est bien installé et démarré :

#terminal[
  \$ sudo systemctl status nginx
]

#success[
Si Nginx est correctement installé, vous devriez voir le service actif (running).
]

= Configuration de Nginx

== Configuration du site par défaut

Modifiez le fichier de configuration du site par défaut :

#file-edit(
  "/etc/nginx/sites-available/default",
  ```
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    
    server_name _;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
  ```
)

== Test de la configuration

Avant de redémarrer Nginx, testez la configuration :

#terminal[
  \$ sudo nginx -t
]

#danger[
Si la commande retourne des erreurs, ne redémarrez pas Nginx. Corrigez d'abord les erreurs de configuration.
]

== Redémarrage du service

Si le test est réussi, redémarrez Nginx :

#terminal[
  \$ sudo systemctl restart nginx
]

= Configuration SSL/TLS

== Installation de Certbot

Pour obtenir un certificat SSL gratuit avec Let's Encrypt :

#terminal[
  \$ sudo apt install certbot python3-certbot-nginx -y
]

== Obtention du certificat

Remplacez `example.com` par votre nom de domaine :

#terminal[
  \$ sudo certbot --nginx -d example.com -d www.example.com
]

#info[
Certbot va automatiquement configurer Nginx pour utiliser le certificat SSL.
]

= Maintenance

== Renouvellement des certificats

Les certificats Let's Encrypt sont valides 90 jours. Testez le renouvellement automatique :

#terminal[
  \$ sudo certbot renew --dry-run
]

== Vérification des logs

Pour consulter les logs de Nginx :

#terminal[
  \$ sudo tail -f /var/log/nginx/access.log
  \$ sudo tail -f /var/log/nginx/error.log
]

= Dépannage

== Nginx ne démarre pas

1. Vérifiez la configuration : `sudo nginx -t`
2. Vérifiez les logs d'erreur : `sudo journalctl -u nginx`
3. Vérifiez que le port 80 n'est pas déjà utilisé : `sudo netstat -tlnp | grep :80`

== Page non accessible

1. Vérifiez que le firewall autorise le trafic HTTP/HTTPS :

#terminal[
  \$ sudo ufw status
  \$ sudo ufw allow 'Nginx Full'
]

2. Vérifiez que Nginx est en cours d'exécution :

#terminal[
  \$ sudo systemctl status nginx
]

= Références

- Documentation officielle Nginx : https://nginx.org/en/docs/
- Documentation Let's Encrypt : https://letsencrypt.org/docs/
- Guide Ubuntu Server : https://ubuntu.com/server/docs

= Conclusion

Cette procédure vous a permis d'installer et de configurer Nginx avec SSL/TLS sur Ubuntu 22.04 LTS. Pour toute question ou problème, contactez l'équipe infrastructure.
