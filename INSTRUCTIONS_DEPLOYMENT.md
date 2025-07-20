# 🚀 Instructions de Déploiement sur GitHub Pages

## Étape 1 : Créer un Repository GitHub

1. **Connectez-vous à GitHub** : [https://github.com](https://github.com)
2. **Créez un nouveau repository** :
   - Cliquez sur le bouton "New" ou "+"
   - Nommez votre repository (ex: `tutoriel-meningite-r`)
   - Cochez "Add a README file"
   - Cliquez "Create repository"

## Étape 2 : Uploader les Fichiers

### Option A : Interface Web GitHub (Plus Simple)
1. Dans votre repository, cliquez "uploading an existing file"
2. Glissez-déposez tous les fichiers de ce dossier :
   - `index.html`
   - `code_R_final_meningite_BF.R`
   - `tableau_final_indicateurs_BF.csv`
   - `README.md`
   - `.gitignore`
3. Ajoutez un message de commit : "Ajout du tutoriel épidémiologie R"
4. Cliquez "Commit changes"

### Option B : Git en Ligne de Commande
```bash
# Cloner votre repository
git clone https://github.com/VOTRE-USERNAME/VOTRE-REPOSITORY.git
cd VOTRE-REPOSITORY

# Copier les fichiers dans le dossier
# (copiez tous les fichiers de ce dossier)

# Ajouter et commiter
git add .
git commit -m "Ajout du tutoriel épidémiologie R"
git push origin main
```

## Étape 3 : Activer GitHub Pages

1. **Allez dans les Settings** de votre repository
2. **Scrollez jusqu'à "Pages"** dans le menu de gauche
3. **Configurez la source** :
   - Source : "Deploy from a branch"
   - Branch : "main" (ou "master")
   - Folder : "/ (root)"
4. **Cliquez "Save"**

## Étape 4 : Accéder à votre Site

- **URL de votre tutoriel** : `https://VOTRE-USERNAME.github.io/VOTRE-REPOSITORY/`
- Le déploiement prend 2-5 minutes
- Vous recevrez un email de confirmation

## 🎯 Exemple d'URL Final

Si votre username GitHub est `prof_epidemio` et votre repository `tutoriel-meningite-r` :
**URL finale** : `https://prof_epidemio.github.io/tutoriel-meningite-r/`

## 📝 Personnalisation

### Modifier le README.md
Remplacez dans le fichier `README.md` :
- `votre-username` par votre vrai username GitHub
- `nom-du-repository` par le nom de votre repository
- Ajoutez vos informations de contact

### Ajouter votre Logo/Institution
Vous pouvez modifier le fichier `index.html` pour :
- Ajouter le logo de votre institution
- Personnaliser les couleurs
- Ajouter vos informations de contact

## 🔄 Mises à Jour

Pour mettre à jour le tutoriel :
1. Modifiez les fichiers localement
2. Uploadez les nouveaux fichiers sur GitHub
3. Les changements apparaîtront automatiquement sur votre site

## 🎓 Partage avec les Étudiants

Une fois déployé, partagez simplement l'URL avec vos étudiants :
- Ajoutez l'URL dans votre syllabus
- Envoyez par email
- Intégrez dans votre LMS (Moodle, Canvas, etc.)

## 🆘 Dépannage

### Le site ne s'affiche pas
- Vérifiez que GitHub Pages est activé
- Attendez 5-10 minutes après l'activation
- Vérifiez que le fichier s'appelle bien `index.html`

### Erreur 404
- Vérifiez l'URL (respectez les majuscules/minuscules)
- Assurez-vous que le repository est public

### Problème d'affichage
- Vérifiez que tous les fichiers sont bien uploadés
- Testez d'abord en local en ouvrant `index.html`

## 📞 Support

Si vous rencontrez des problèmes :
1. Consultez la [documentation GitHub Pages](https://docs.github.com/en/pages)
2. Vérifiez les [status GitHub](https://www.githubstatus.com/)
3. Contactez le support GitHub si nécessaire

---

**Bonne chance avec votre déploiement ! 🚀**

