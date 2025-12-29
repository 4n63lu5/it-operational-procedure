# IT Operational Procedure - Package Typst

Un package Typst professionnel pour la rédaction de procédures informatiques avec gestion des versions, approbations et styles personnalisés.

## 📋 Fonctionnalités

### Structure et Métadonnées
- **Numérotation de document** : Identifiant unique pour chaque procédure
- **Gestion des versions** : Système de versioning sémantique (ex: 1.2.0)
- **Date de dernière édition** : Suivi automatique des dates
- **Historique des révisions** : Tableau complet des modifications
- **Système d'approbation** : Suivi des validateurs et approbateurs

### Indicateurs de Sécurité
- **TLP (Traffic Light Protocol)** : Indicateurs de confidentialité
  - TLP:RED - Information hautement confidentielle
  - TLP:AMBER - Information à diffusion limitée
  - TLP:GREEN - Information communautaire
  - TLP:WHITE/CLEAR - Information publique

### Styles Spécialisés

#### Commandes Terminal
Style avec texte vert sur fond noir pour les commandes shell :
```typst
#terminal[
  $ sudo apt update
  $ sudo systemctl restart nginx
]
```

#### Édition de Fichiers
Style distinct pour indiquer la modification de fichiers :
```typst
#file-edit("/etc/nginx/nginx.conf", [
  server {
    listen 80;
    server_name example.com;
  }
])
```

#### Boîtes d'Information
- `#info[]` - Informations générales (bleu)
- `#warning[]` - Avertissements (orange)
- `#success[]` - Messages de succès (vert)
- `#danger[]` - Erreurs et dangers (rouge)
- `#code-block[]` - Blocs de code génériques

## 🚀 Installation

### Installation via Typst Package Manager (recommandé)
```bash
# À venir lors de la publication sur le registry officiel
typst install it-operational-procedure
```

### Installation manuelle
1. Cloner le dépôt :
```bash
git clone https://github.com/4n63lu5/it-operational-procedure.git
```

2. Copier les fichiers dans votre projet ou utiliser l'import local

## 📖 Utilisation

### Exemple Basique

```typst
#import "lib.typ": *

#show: procedure.with(
  title: "Installation de PostgreSQL",
  doc-number: "PROC-042",
  version: "1.0.0",
  date: "29/12/2024",
  author: "Équipe DBA",
  tlp-level: "green"
)

= Introduction
Contenu de votre procédure...

= Étapes d'installation

#terminal[
  $ sudo apt install postgresql
]

#success[
PostgreSQL a été installé avec succès!
]
```

### Avec Historique de Révisions

```typst
#show: procedure.with(
  title: "Sauvegarde des Bases de Données",
  doc-number: "PROC-015",
  version: "2.1.0",
  date: "29/12/2024",
  author: "Équipe Infrastructure",
  tlp-level: "amber",
  revisions: (
    (version: "1.0.0", date: "01/01/2024", author: "J. Dupont", 
     description: "Création initiale"),
    (version: "2.0.0", date: "15/06/2024", author: "M. Martin", 
     description: "Ajout de la sauvegarde incrémentale"),
    (version: "2.1.0", date: "29/12/2024", author: "J. Dupont", 
     description: "Optimisation des scripts"),
  ),
  approvers: (
    (role: "Rédacteur", name: "Jean Dupont", signature: ""),
    (role: "Validateur", name: "Marie Martin", signature: ""),
    (role: "Approbateur", name: "Directeur IT", signature: ""),
  )
)

// Votre contenu ici...
```

### Exemples de Styles

```typst
// Terminal
#terminal[
  $ cd /var/www
  $ sudo systemctl restart apache2
]

// Édition de fichier
#file-edit("/etc/hosts", [
  127.0.0.1  localhost
  192.168.1.10  server.example.com
])

// Informations
#info[
Cette procédure nécessite des privilèges administrateur.
]

// Avertissement
#warning[
Sauvegardez vos données avant de continuer.
]

// Succès
#success[
La configuration a été appliquée avec succès.
]

// Danger
#danger[
Cette opération est irréversible. Procédez avec précaution.
]
```

## 📁 Structure du Package

```
it-operational-procedure/
├── typst.toml          # Métadonnées du package
├── lib.typ             # Bibliothèque principale
├── example.typ         # Exemple d'utilisation
├── README.md           # Documentation
└── LICENSE             # Licence MIT
```

## 🎨 Personnalisation

### Modifier les Couleurs TLP

```typst
// Les couleurs TLP sont définies dans lib.typ
// Vous pouvez les personnaliser selon vos besoins
```

### Ajouter des Styles Personnalisés

```typst
#let custom-box(body) = {
  block(
    fill: rgb("#E8F4F8"),
    stroke: (left: 4pt + rgb("#0077B6")),
    inset: 10pt,
    radius: 3pt,
    width: 100%,
    body
  )
}
```

## 📝 Fonctions Disponibles

### Template Principal
- `procedure()` - Template de document principal avec toutes les options

### Indicateurs
- `tlp-indicator(level)` - Affiche un badge TLP (red/amber/green/white/clear)

### Styles de Blocs
- `terminal(body)` - Bloc de commandes terminal (vert sur noir)
- `file-edit(path, body)` - Bloc d'édition de fichier
- `info(body)` - Boîte d'information
- `warning(body)` - Boîte d'avertissement
- `success(body)` - Boîte de succès
- `danger(body)` - Boîte de danger
- `code-block(body)` - Bloc de code générique

### Gestion des Versions
- `revision-history(entries)` - Tableau d'historique des révisions
- `approval-section(approvers)` - Tableau des approbations

## 🔧 Compilation

Pour compiler un document Typst :

```bash
# Compiler en PDF
typst compile example.typ

# Mode watch (recompilation automatique)
typst watch example.typ

# Spécifier un fichier de sortie
typst compile example.typ output.pdf
```

## 📄 Exemple Complet

Voir le fichier `example.typ` pour un exemple complet d'utilisation incluant :
- Page de titre avec métadonnées
- Historique des révisions
- Tableau d'approbation
- Table des matières
- Contenu avec tous les styles disponibles
- Numérotation des pages
- En-têtes et pieds de page personnalisés

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
- Signaler des bugs
- Proposer de nouvelles fonctionnalités
- Soumettre des pull requests
- Améliorer la documentation

## 📜 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 🔗 Liens Utiles

- [Documentation Typst](https://typst.app/docs)
- [Traffic Light Protocol](https://www.first.org/tlp/)
- [Exemples de procédures IT](https://github.com/4n63lu5/it-operational-procedure/tree/main)

## ✨ Auteur

Créé et maintenu par [@4n63lu5](https://github.com/4n63lu5)

---

**Note** : Ce package est conçu spécifiquement pour les professionnels de l'informatique devant documenter des procédures opérationnelles avec un niveau de formalisme et de traçabilité élevé.
