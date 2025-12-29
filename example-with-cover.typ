#import "lib.typ": *

#show: procedure.with(
  title: "Installation et Configuration de PostgreSQL",
  doc-number: "PROC-042",
  version: "1.0.0",
  date: "29/12/2024",
  author: "Équipe DBA",
  tlp-level: "amber",
  // Enable cover page with logo and QR code
  enable-cover-page: true,
  cover-logo: "assets/logo.svg",
  cover-qr-code-image: "assets/sample-qrcode.png",
  cover-qr-uuid: "550e8400-e29b-41d4-a716-446655440000",
  revisions: (
    (version: "1.0.0", date: "29/12/2024", author: "J. Dupont", description: "Création initiale"),
  ),
  approvers: (
    (role: "Rédacteur", name: "Jean Dupont", signature: ""),
    (role: "Validateur Technique", name: "Marie Martin", signature: ""),
    (role: "Approbateur", name: "Pierre Durand", signature: ""),
  )
)

= Introduction

Ce document décrit la procédure d'installation et de configuration du système de gestion de base de données PostgreSQL sur un système Linux Ubuntu 22.04 LTS.

#info[
Cette procédure s'applique aux environnements de production. Un UUID unique est associé à ce document pour traçabilité et vérification.
]

= Prérequis

Avant de commencer, assurez-vous que :

- Vous avez un accès root ou sudo au serveur
- Le serveur est connecté à Internet
- Au moins 2 GB de RAM disponible
- Au moins 10 GB d'espace disque disponible

#warning[
Cette procédure nécessite des privilèges administrateur. Assurez-vous d'avoir les autorisations nécessaires avant de continuer.
]

= Installation de PostgreSQL

== Mise à jour du système

Commencez par mettre à jour la liste des paquets disponibles :

#terminal[
  \$ sudo apt update
  \$ sudo apt upgrade -y
]

== Installation du paquet PostgreSQL

Installez PostgreSQL avec la commande suivante :

#terminal[
  \$ sudo apt install postgresql postgresql-contrib -y
]

== Vérification de l'installation

Vérifiez que PostgreSQL est bien installé et démarré :

#terminal[
  \$ sudo systemctl status postgresql
]

#success[
Si PostgreSQL est correctement installé, vous devriez voir le service actif (running).
]

= Configuration Initiale

== Accès à la console PostgreSQL

Connectez-vous à la console PostgreSQL avec l'utilisateur postgres :

#terminal[
  \$ sudo -u postgres psql
]

== Création d'un utilisateur

Dans la console PostgreSQL, créez un nouvel utilisateur :

#terminal[
  postgres=\# CREATE USER dbadmin WITH PASSWORD 'secure_password';
  postgres=\# ALTER USER dbadmin CREATEDB;
]

#danger[
N'oubliez pas de choisir un mot de passe sécurisé pour l'utilisateur de base de données.
]

= Sécurité

== Configuration de l'authentification

Modifiez le fichier de configuration pour sécuriser l'accès :

#file-edit(
  "/etc/postgresql/14/main/pg_hba.conf",
  ```
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             postgres                                peer
local   all             all                                     md5
host    all             all             127.0.0.1/32            md5
host    all             all             ::1/128                 md5
  ```
)

== Redémarrage du service

Après modification, redémarrez PostgreSQL :

#terminal[
  \$ sudo systemctl restart postgresql
]

= Vérification

Testez la connexion avec le nouvel utilisateur :

#terminal[
  \$ psql -U dbadmin -h localhost -d postgres
]

#success[
Si vous pouvez vous connecter, PostgreSQL est correctement configuré.
]

= Conclusion

Cette procédure vous a permis d'installer et de configurer PostgreSQL sur Ubuntu 22.04 LTS. Pour toute question ou problème, contactez l'équipe DBA.
