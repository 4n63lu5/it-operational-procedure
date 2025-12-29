# Architecture et Utilisation du Package

## Architecture du Package

### Structure des Fichiers

```
it-operational-procedure/
├── typst.toml      # Manifeste du package
├── lib.typ         # Bibliothèque principale
├── example.typ     # Exemple complet
├── template.typ    # Modèle de départ
└── README.md       # Documentation
```

### Composants Principaux

#### 1. Template de Document (`procedure`)

Le template principal qui structure tout le document avec :
- Page de garde avec métadonnées
- En-têtes et pieds de page personnalisés
- Historique des révisions
- Tableau d'approbation
- Table des matières
- Styles de titres cohérents

#### 2. Indicateur TLP (`tlp-indicator`)

Gère les 5 niveaux de classification :
- **TLP:RED** - Information hautement confidentielle, distribution très restreinte
- **TLP:AMBER** - Information sensible, distribution limitée
- **TLP:GREEN** - Information communautaire, pas de distribution publique
- **TLP:WHITE** - Information publique (ancienne nomenclature)
- **TLP:CLEAR** - Information publique (nouvelle nomenclature)

#### 3. Styles de Blocs Spécialisés

##### Terminal (`terminal`)
Pour les commandes shell avec style vert sur noir.

##### File Edit (`file-edit`)
Pour indiquer la modification de fichiers de configuration.

##### Boîtes d'Information
- `info` - Informations générales (bleu)
- `warning` - Avertissements (orange)
- `success` - Confirmations (vert)
- `danger` - Erreurs critiques (rouge)

## Patterns d'Utilisation

### Cas d'Usage 1 : Procédure Simple

```typst
#import "lib.typ": *

#show: procedure.with(
  title: "Installation de PostgreSQL",
  doc-number: "PROC-042",
  version: "1.0.0",
  date: "29/12/2024",
  author: "DBA Team",
  tlp-level: "green"
)

= Installation

#terminal[
  $ sudo apt install postgresql
]
```

### Cas d'Usage 2 : Procédure avec Révisions

Pour une procédure évolutive avec historique complet :

```typst
#show: procedure.with(
  title: "Sauvegarde des Bases de Données",
  doc-number: "PROC-015",
  version: "2.1.0",
  revisions: (
    (version: "1.0.0", date: "01/01/2024", author: "J. Dupont", 
     description: "Création initiale"),
    (version: "2.0.0", date: "15/06/2024", author: "M. Martin", 
     description: "Ajout sauvegarde incrémentale"),
    (version: "2.1.0", date: "29/12/2024", author: "J. Dupont", 
     description: "Optimisation"),
  )
)
```

### Cas d'Usage 3 : Procédure Sécurisée avec Approbations

Pour les procédures critiques nécessitant validation :

```typst
#show: procedure.with(
  title: "Procédure de Reprise après Sinistre",
  doc-number: "PROC-999",
  version: "3.0.0",
  tlp-level: "red",
  approvers: (
    (role: "Rédacteur", name: "Jean Dupont", signature: "JD - 15/12/2024"),
    (role: "RSSI", name: "Marie Martin", signature: "MM - 18/12/2024"),
    (role: "DSI", name: "Pierre Durand", signature: "PD - 20/12/2024"),
  )
)
```

## Bonnes Pratiques

### 1. Numérotation des Documents

Utilisez un système cohérent :
- `PROC-001` à `PROC-099` : Procédures d'installation
- `PROC-100` à `PROC-199` : Procédures de maintenance
- `PROC-200` à `PROC-299` : Procédures de sécurité
- `PROC-300` à `PROC-399` : Procédures de sauvegarde
- etc.

### 2. Versioning Sémantique

Suivez le format MAJOR.MINOR.PATCH :
- **MAJOR** : Changements incompatibles ou restructuration majeure
- **MINOR** : Ajout de fonctionnalités rétrocompatibles
- **PATCH** : Corrections et améliorations mineures

### 3. Classification TLP

Choisissez le niveau approprié :
- **RED** : Procédures de sécurité critiques, mots de passe, clés
- **AMBER** : Procédures internes avec informations sensibles
- **GREEN** : Procédures standard pour l'équipe IT
- **CLEAR** : Procédures publiques, guides utilisateur

### 4. Organisation du Contenu

Structure recommandée :
1. Introduction (contexte et objectif)
2. Prérequis (permissions, outils, accès)
3. Procédure principale (étapes numérotées)
4. Vérifications (tests de validation)
5. Dépannage (problèmes courants)
6. Références (documentation externe)
7. Conclusion

### 5. Utilisation des Styles

#### Commandes Terminal
Toujours utiliser `terminal` pour les commandes shell :
```typst
#terminal[
  $ sudo systemctl restart nginx
]
```

#### Édition de Fichiers
Utiliser `file-edit` avec le chemin complet :
```typst
#file-edit("/etc/nginx/nginx.conf", [
  server {
    listen 80;
  }
])
```

#### Alertes et Informations
- Utiliser `info` pour contexte et explications
- Utiliser `warning` pour précautions importantes
- Utiliser `danger` pour actions irréversibles
- Utiliser `success` pour confirmations de succès

## Personnalisation Avancée

### Couleurs Personnalisées

Vous pouvez modifier les couleurs TLP dans `lib.typ` :

```typst
#let tlp-colors = (
  red: (bg: rgb("#FF0033"), fg: white, label: "TLP:RED"),
  // Personnalisez selon vos besoins
)
```

### Ajout de Nouveaux Styles

Créez vos propres styles de bloc :

```typst
#let custom-note(body) = {
  block(
    fill: rgb("#E8F4F8"),
    stroke: (left: 4pt + rgb("#0077B6")),
    inset: 10pt,
    radius: 3pt,
    width: 100%,
    [
      #text(fill: rgb("#0077B6"), weight: "bold")[📌 Note]
      #v(5pt)
      #body
    ]
  )
}
```

## Compilation et Export

### Compilation Simple
```bash
typst compile procedure.typ
```

### Mode Watch (développement)
```bash
typst watch procedure.typ
```

### Export avec Nom Personnalisé
```bash
typst compile procedure.typ output/PROC-001-v1.0.0.pdf
```

### Compilation Multiple
```bash
for file in *.typ; do
  typst compile "$file" "pdf/${file%.typ}.pdf"
done
```

## Intégration CI/CD

### GitHub Actions

```yaml
name: Compile Procedures
on: [push]
jobs:
  compile:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Typst
        run: |
          curl -fsSL https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz | tar -xJ
          sudo mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/
      - name: Compile Documents
        run: typst compile procedures/*.typ
      - name: Upload PDFs
        uses: actions/upload-artifact@v3
        with:
          name: procedures
          path: '**/*.pdf'
```

## Support et Contribution

Pour toute question ou suggestion :
1. Ouvrir une issue sur GitHub
2. Proposer une pull request
3. Consulter la documentation Typst officielle

## Ressources

- [Documentation Typst](https://typst.app/docs)
- [Traffic Light Protocol](https://www.first.org/tlp/)
- [Guide de rédaction de procédures IT](https://www.itil.org/)
