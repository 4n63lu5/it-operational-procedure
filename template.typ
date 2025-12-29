#import "lib.typ": *

#show: procedure.with(
  title: "Titre de la Procédure",
  doc-number: "PROC-XXX",
  version: "1.0.0",
  date: "JJ/MM/AAAA",
  author: "Votre Nom",
  tlp-level: "clear",  // Options: red, amber, green, white, clear
  revisions: (
    // Décommenter et remplir selon les besoins
    // (version: "1.0.0", date: "01/01/2024", author: "Auteur", description: "Création initiale"),
  ),
  approvers: (
    // Décommenter et remplir selon les besoins
    // (role: "Rédacteur", name: "Nom Prénom", signature: ""),
    // (role: "Validateur", name: "Nom Prénom", signature: ""),
    // (role: "Approbateur", name: "Nom Prénom", signature: ""),
  )
)

= Introduction

Décrivez l'objectif de cette procédure.

#info[
Ajoutez ici des informations importantes pour le contexte.
]

= Prérequis

Liste des prérequis nécessaires :

- Prérequis 1
- Prérequis 2
- Prérequis 3

#warning[
Ajoutez des avertissements importants ici.
]

= Procédure

== Étape 1 : Titre de l'étape

Description de l'étape.

=== Commandes à exécuter

Utilisez le style terminal pour les commandes :

#terminal[
  \$ commande1
  \$ commande2
]

=== Édition de fichier

Pour indiquer la modification d'un fichier :

#file-edit("/chemin/vers/fichier.conf", [
  contenu du fichier
  ligne 2
  ligne 3
])

== Étape 2 : Vérification

Vérifiez que tout fonctionne correctement.

#success[
Message de succès après vérification réussie.
]

#danger[
Message d'erreur en cas de problème critique.
]

= Dépannage

== Problème 1

Description du problème et solution.

== Problème 2

Description du problème et solution.

= Références

- Référence 1 : https://example.com
- Référence 2 : Documentation officielle

= Conclusion

Résumé et remarques finales.
