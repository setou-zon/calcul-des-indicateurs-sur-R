# ===============================================================================
# ANALYSE ÉPIDÉMIOLOGIQUE DE LA MÉNINGITE - BURKINA FASO 2025
# Code R utilisant tidyverse selon les recommandations du Epi R Handbook
# https://epirhandbook.com/en/new_pages/transition_to_R.html
# ===============================================================================

# Charger les packages nécessaires
library(readxl)      # Pour lire les fichiers Excel
library(dplyr)       # Pour la manipulation de données
library(tidyr)       # Pour le nettoyage et la restructuration
library(ggplot2)     # Pour les visualisations
library(knitr)       # Pour les tableaux formatés

# ===============================================================================
# 1. IMPORTATION ET EXPLORATION DES DONNÉES
# ===============================================================================

# Lire le fichier Excel
burkina_meningite <- read_excel("Base_Méningite_BF_corrige.xlsx")

# Exploration initiale
cat("ANALYSE ÉPIDÉMIOLOGIQUE MÉNINGITE - BURKINA FASO 2025\n")
cat("=====================================================\n")
cat("Nombre total de cas:", nrow(burkina_meningite), "\n")
cat("Période d'étude: Semaines épidémiologiques 1 à 27 de 2025\n\n")

# ===============================================================================
# 2. NETTOYAGE ET PRÉPARATION DES DONNÉES
# ===============================================================================

# Sélectionner et nettoyer les variables clés
donnees_propres <- burkina_meningite %>%
  select(
    region,
    district,
    semaine_epi,                    # Semaine épidémiologique
    age_en_annees,
    sexe,
    evolution_du_cas,               # Évolution du patient
    resultat_final_national,        # Résultat final après examen labo
    classification_finale           # Classification du cas
  ) %>%
  mutate(
    # Standardiser l'évolution du cas
    evolution = case_when(
      str_to_lower(evolution_du_cas) %in% c("decede", "décédé") ~ "Décédé",
      str_to_lower(evolution_du_cas) %in% c("vivant", "gueri", "guéri") ~ "Vivant",
      str_to_lower(evolution_du_cas) == "traitement" ~ "En traitement",
      TRUE ~ "Statut inconnu"
    ),
    
    # Standardiser la classification
    statut_cas = case_when(
      classification_finale == "Cas confirmé" ~ "Confirmé",
      classification_finale == "Cas probable" ~ "Probable",
      classification_finale == "Cas suspects" ~ "Suspect",
      TRUE ~ "Non classé"
    ),
    
    # Créer des groupes d'âge selon les recommandations OMS
    groupe_age = case_when(
      age_en_annees < 1 ~ "< 1 an",
      age_en_annees >= 1 & age_en_annees < 5 ~ "1-4 ans",
      age_en_annees >= 5 & age_en_annees < 15 ~ "5-14 ans",
      age_en_annees >= 15 & age_en_annees < 30 ~ "15-29 ans",
      age_en_annees >= 30 ~ "30+ ans",
      TRUE ~ "Âge inconnu"
    ),
    
    # Nettoyer le résultat final du laboratoire
    agent_pathogene = case_when(
      str_detect(resultat_final_national, "S\\. pneumoniae|Spneumoniae") ~ "S. pneumoniae",
      str_detect(resultat_final_national, "NmC") ~ "N. meningitidis C",
      str_detect(resultat_final_national, "NmW") ~ "N. meningitidis W",
      str_detect(resultat_final_national, "Hib") ~ "H. influenzae b",
      str_detect(resultat_final_national, "Hi non b") ~ "H. influenzae non b",
      str_detect(resultat_final_national, "Négatif|NEGATIF") ~ "Négatif",
      TRUE ~ "Autre/Indéterminé"
    )
  )

# ===============================================================================
# 3. CALCUL DES INDICATEURS ÉPIDÉMIOLOGIQUES PAR RÉGION
# ===============================================================================

# Indicateurs par région selon les standards épidémiologiques
indicateurs_region <- donnees_propres %>%
  group_by(region) %>%
  summarise(
    # Nombre de cas
    total_cas = n(),
    cas_confirmes = sum(statut_cas == "Confirmé", na.rm = TRUE),
    cas_probables = sum(statut_cas == "Probable", na.rm = TRUE),
    cas_suspects = sum(statut_cas == "Suspect", na.rm = TRUE),
    
    # Évolution des cas
    deces = sum(evolution == "Décédé", na.rm = TRUE),
    vivants = sum(evolution == "Vivant", na.rm = TRUE),
    
    # Calcul du Taux de Létalité (Case Fatality Rate - CFR)
    # CFR = (Nombre de décès / Nombre total de cas) × 100
    taux_letalite_pct = round((deces / total_cas) * 100, 2),
    
    # Proportion de cas confirmés
    prop_confirmes_pct = round((cas_confirmes / total_cas) * 100, 2),
    
    # Statistiques démographiques
    age_median = round(median(age_en_annees, na.rm = TRUE), 1),
    prop_masculin_pct = round((sum(sexe == "M", na.rm = TRUE) / n()) * 100, 1),
    
    .groups = 'drop'
  ) %>%
  # Trier par nombre de cas décroissant
  arrange(desc(total_cas))

# ===============================================================================
# 4. ANALYSE TEMPORELLE PAR SEMAINE ÉPIDÉMIOLOGIQUE
# ===============================================================================

# Évolution temporelle des cas
evolution_temporelle <- donnees_propres %>%
  group_by(semaine_epi) %>%
  summarise(
    nouveaux_cas = n(),
    nouveaux_deces = sum(evolution == "Décédé", na.rm = TRUE),
    cas_confirmes = sum(statut_cas == "Confirmé", na.rm = TRUE),
    
    # Taux de létalité hebdomadaire
    taux_letalite_hebdo = if_else(nouveaux_cas > 0, 
                                  round((nouveaux_deces / nouveaux_cas) * 100, 2), 
                                  0),
    .groups = 'drop'
  ) %>%
  # Calculer les cas cumulés
  mutate(
    cas_cumules = cumsum(nouveaux_cas),
    deces_cumules = cumsum(nouveaux_deces)
  ) %>%
  arrange(semaine_epi)

# ===============================================================================
# 5. ANALYSE DES AGENTS PATHOGÈNES
# ===============================================================================

# Répartition des agents pathogènes identifiés
agents_pathogenes <- donnees_propres %>%
  filter(!is.na(agent_pathogene), agent_pathogene != "Autre/Indéterminé") %>%
  count(agent_pathogene, sort = TRUE) %>%
  mutate(
    pourcentage = round((n / sum(n)) * 100, 1)
  ) %>%
  rename(
    "Agent pathogène" = agent_pathogene,
    "Nombre de cas" = n,
    "Pourcentage" = pourcentage
  )

# ===============================================================================
# 6. INDICATEURS GLOBAUX BURKINA FASO
# ===============================================================================

# Calcul des indicateurs nationaux
indicateurs_nationaux <- donnees_propres %>%
  summarise(
    # Effectifs
    total_cas_national = n(),
    cas_confirmes_national = sum(statut_cas == "Confirmé", na.rm = TRUE),
    cas_probables_national = sum(statut_cas == "Probable", na.rm = TRUE),
    cas_suspects_national = sum(statut_cas == "Suspect", na.rm = TRUE),
    deces_national = sum(evolution == "Décédé", na.rm = TRUE),
    
    # Indicateurs clés
    taux_letalite_national = round((deces_national / total_cas_national) * 100, 2),
    prop_confirmes_national = round((cas_confirmes_national / total_cas_national) * 100, 2),
    
    # Démographie
    age_median_national = round(median(age_en_annees, na.rm = TRUE), 1),
    prop_masculin_national = round((sum(sexe == "M", na.rm = TRUE) / n()) * 100, 1),
    
    # Période d'étude
    premiere_semaine = min(semaine_epi, na.rm = TRUE),
    derniere_semaine = max(semaine_epi, na.rm = TRUE)
  )

# ===============================================================================
# 7. CRÉATION DU TABLEAU RÉCAPITULATIF FINAL
# ===============================================================================

# Tableau principal avec les indicateurs par région
tableau_principal <- indicateurs_region %>%
  select(
    "Région" = region,
    "Total cas" = total_cas,
    "Cas confirmés" = cas_confirmes,
    "Décès" = deces,
    "Taux de létalité (%)" = taux_letalite_pct,
    "% Cas confirmés" = prop_confirmes_pct,
    "Âge médian" = age_median
  )

# Ajouter la ligne nationale
ligne_nationale <- tibble(
  "Région" = "BURKINA FASO (TOTAL)",
  "Total cas" = indicateurs_nationaux$total_cas_national,
  "Cas confirmés" = indicateurs_nationaux$cas_confirmes_national,
  "Décès" = indicateurs_nationaux$deces_national,
  "Taux de létalité (%)" = indicateurs_nationaux$taux_letalite_national,
  "% Cas confirmés" = indicateurs_nationaux$prop_confirmes_national,
  "Âge médian" = indicateurs_nationaux$age_median_national
)

tableau_final <- bind_rows(tableau_principal, ligne_nationale)

# ===============================================================================
# 8. AFFICHAGE DES RÉSULTATS
# ===============================================================================

# Afficher les résultats principaux
cat("INDICATEURS ÉPIDÉMIOLOGIQUES PAR RÉGION\n")
cat("========================================\n")
print(tableau_final)

cat("\n\nÉVOLUTION TEMPORELLE (5 premières semaines)\n")
cat("============================================\n")
print(head(evolution_temporelle, 5))

cat("\n\nAGENTS PATHOGÈNES IDENTIFIÉS\n")
cat("=============================\n")
print(agents_pathogenes)

cat("\n\nRÉSUMÉ NATIONAL\n")
cat("===============\n")
cat("Période d'étude:", indicateurs_nationaux$premiere_semaine, "à", indicateurs_nationaux$derniere_semaine, "\n")
cat("Total des cas:", indicateurs_nationaux$total_cas_national, "\n")
cat("Cas confirmés:", indicateurs_nationaux$cas_confirmes_national, "\n")
cat("Décès:", indicateurs_nationaux$deces_national, "\n")
cat("Taux de létalité national:", indicateurs_nationaux$taux_letalite_national, "%\n")
cat("Âge médian:", indicateurs_nationaux$age_median_national, "ans\n")

# ===============================================================================
# 9. SAUVEGARDE DES RÉSULTATS
# ===============================================================================

# Sauvegarder les tableaux en CSV
write.csv(tableau_final, "tableau_indicateurs_regions_BF.csv", row.names = FALSE)
write.csv(evolution_temporelle, "evolution_temporelle_BF.csv", row.names = FALSE)
write.csv(agents_pathogenes, "agents_pathogenes_BF.csv", row.names = FALSE)

cat("\n\nFichiers sauvegardés:\n")
cat("- tableau_indicateurs_regions_BF.csv\n")
cat("- evolution_temporelle_BF.csv\n")
cat("- agents_pathogenes_BF.csv\n")

cat("\n✓ Analyse terminée avec succès!\n")
cat("✓ Tous les indicateurs calculés selon les standards épidémiologiques\n")
cat("✓ Code compatible avec les recommandations du Epi R Handbook\n")

