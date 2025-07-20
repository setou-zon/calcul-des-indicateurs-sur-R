# Tutoriel : Analyse Épidémiologique de la Méningite avec R et Tidyverse

## 📊 Description

Ce repository contient un tutoriel complet pour apprendre l'analyse épidémiologique avec R et tidyverse, en utilisant des données réelles de surveillance de la méningite au Burkina Faso (2025).

## 🎯 Objectifs d'apprentissage

À la fin de ce tutoriel, les étudiants seront capables de :
- Importer et nettoyer des données épidémiologiques avec R
- Calculer les indicateurs épidémiologiques standards
- Utiliser les packages tidyverse pour l'analyse de données
- Interpréter les résultats d'une analyse épidémiologique

## 📁 Contenu du Repository

- **`index.html`** : Page web tutoriel interactive (accessible via GitHub Pages)
- **`code_R_final_meningite_BF.R`** : Script R complet avec tous les calculs
- **`tableau_final_indicateurs_BF.csv`** : Résultats finaux de l'analyse
- **`README.md`** : Ce fichier de documentation

## 🌐 Accès au Tutoriel

### Option 1 : GitHub Pages (Recommandé)
Accédez directement au tutoriel interactif en ligne :
**[Lien vers le tutoriel](https://votre-username.github.io/nom-du-repository/)**

### Option 2 : Téléchargement local
1. Clonez ce repository : `git clone https://github.com/votre-username/nom-du-repository.git`
2. Ouvrez le fichier `index.html` dans votre navigateur

## 📚 Données Analysées

- **Source** : Base de données de surveillance de la méningite, Burkina Faso
- **Période** : Semaines épidémiologiques 1 à 27 de 2025
- **Cas totaux** : 1 157 cas
- **Régions** : 13 régions administratives

## 🔍 Indicateurs Calculés

### Indicateurs Nationaux
- **Total des cas** : 1 157
- **Décès** : 26
- **Taux de létalité** : 2,25%
- **Cas confirmés** : 4 (0,35%)
- **Âge médian** : 7 ans

### Indicateurs par Région
- Taux de létalité par région
- Proportion de cas confirmés
- Répartition démographique
- Évolution temporelle

## 🛠️ Technologies Utilisées

- **R** : Langage de programmation statistique
- **Tidyverse** : Collection de packages R pour la science des données
  - `dplyr` : Manipulation de données
  - `tidyr` : Nettoyage des données
  - `ggplot2` : Visualisation
  - `readxl` : Importation de fichiers Excel
- **HTML/CSS/JavaScript** : Interface web interactive
- **Bootstrap** : Framework CSS pour le design responsive

## 📖 Méthodologie

Cette analyse suit les recommandations du **[Epi R Handbook](https://epirhandbook.com/en/new_pages/transition_to_R.html)**, référence internationale pour l'épidémiologie appliquée avec R.

## 🎓 Utilisation Pédagogique

### Pour les Enseignants
- Tutoriel clé en main pour cours d'épidémiologie
- Code R commenté et expliqué étape par étape
- Exercices pratiques inclus
- Données réelles pour contexte authentique

### Pour les Étudiants
- Apprentissage autonome possible
- Interface web intuitive
- Code copiable directement
- Explications détaillées de chaque concept

## 🔧 Installation et Prérequis

### Prérequis R
```r
# Installation des packages nécessaires
install.packages("tidyverse")
install.packages("readxl")
install.packages("knitr")
install.packages("DT")
```

### Chargement des librairies
```r
library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)
library(knitr)
```

## 📊 Résultats Principaux

### Observations Clés
- **Région la plus touchée** : Hauts-Bassins (220 cas, 19% du total)
- **Taux de létalité le plus élevé** : Centre-Sud (5,56%)
- **Pic épidémique** : Semaine 9 (taux de létalité de 10,53%)
- **Population vulnérable** : Enfants (âge médian 7 ans)

### Recommandations
- Renforcer le diagnostic laboratoire (seulement 0,35% de cas confirmés)
- Surveillance renforcée dans les régions à haut risque
- Prévention ciblée pour les enfants de moins de 15 ans
- Amélioration de la prise en charge dans les régions à forte létalité

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
- Signaler des erreurs via les Issues
- Proposer des améliorations
- Ajouter des exercices supplémentaires
- Traduire le contenu

## 📄 Licence

Ce projet est sous licence MIT. Vous êtes libre de l'utiliser, le modifier et le distribuer à des fins éducatives.

## 📞 Contact

Pour toute question concernant ce tutoriel :
- Créez une Issue sur ce repository
- Contactez l'équipe pédagogique

---

**Développé pour l'enseignement de l'épidémiologie appliquée avec R**

