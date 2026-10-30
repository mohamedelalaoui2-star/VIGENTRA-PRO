# VIGENTRA PRO — dossier projet d’amélioration

> Dossier de travail et maquette autonome. Le fichier `maquette.html` utilise uniquement des données fictives locales : il ne se connecte pas à Supabase et ne modifie pas l’application publiée.

## Objectif
Faire évoluer VIGENTRA PRO en outil mobile fiable pour la gestion quotidienne d’une entreprise de sécurité privée : planning, agents, sites, pointage, conformité, clients et pilotage.

## Contenu
- `maquette.html` — prototype responsive français, thème bleu nuit / noir / or champagne / rouge, navigation interactive et données de démonstration.
- `ROADMAP.md` — priorités de développement.
- `SECURITE-ET-TESTS.md` — garde-fous de sécurité et plan de vérification.
- `MODELE-DONNEES.md` — cible fonctionnelle proposée à comparer au schéma existant avant toute migration.

## Ouvrir la maquette
Télécharger ou ouvrir `maquette.html` dans Safari, Chrome ou sur ordinateur. Les chiffres, agents, sites et vacations sont des exemples et ne représentent pas les données de TEA SÉCURITÉ PRIVÉE.

## Règles de travail
1. Sauvegarder les données avant une migration.
2. Auditer le schéma et les politiques RLS existants avant de les modifier.
3. Ne jamais mettre de clé Supabase `service_role` dans le navigateur.
4. Tester avec des comptes dirigeant et agent distincts.
5. Garder les fonctions de production séparées de cette maquette jusqu’à validation.
6. Priorité aux services gratuits, sans API IA payante obligatoire.

## État
- [x] Dossier projet créé.
- [x] Maquette de démonstration responsive.
- [x] Feuille de route et contrôles de sécurité documentés.
- [ ] Audit fonctionnel complet de la version actuellement publiée.
- [ ] Validation des règles métier, tests avec comptes de test et sauvegarde.
- [ ] Intégration progressive après validation explicite.
