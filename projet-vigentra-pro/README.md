# VIGENTRA PRO — dossier projet d’amélioration

> Dossier de travail et maquette autonome. Le fichier `maquette.html` utilise uniquement des données fictives locales : il ne se connecte pas à Supabase et ne modifie pas l’application publiée.

## Objectif
Faire évoluer VIGENTRA PRO en outil mobile fiable pour la gestion quotidienne d’une entreprise de sécurité privée : planning, agents, sites, pointage, conformité, clients et pilotage.

## Contenu
- `maquette.html` — prototype visuel autonome en données fictives.
- `app-v2.html` — version de travail connectable au schéma réel de Planning-vigentra, avec connexion, agents, sites, planning, pointages, qualifications, main courante, brouillons de factures et charges.
- `AUDIT-30-10-2026.md` — constat de compatibilité et résultats des contrôles Supabase en lecture seule.
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

## Vercel — aperçu de test
- Utiliser Vercel pour un aperçu isolé de la branche de travail, après autorisation d'accès à l'équipe et vérification du projet existant.
- Ne pas relier ni déployer la branche de travail sur le domaine de production sans validation explicite.
- Avant publication, vérifier les variables d'environnement Preview, le projet Supabase cible et les règles RLS avec des comptes de test.
- Aucun token Vercel ni clé Supabase secrète ne doit être ajouté au dépôt.
- Aperçu isolé actuel (fichier `app-v2.html` servi comme `index.html`) : https://vigentra-5uh46txjh-mohamedelalaoui2-stars-projects.vercel.app. Cet aperçu n'est pas une validation fonctionnelle et n'a pas d'alias de production.

## État
- [x] Dossier projet créé.
- [x] Maquette de démonstration responsive.
- [x] Version de travail adaptée aux noms de tables et colonnes du projet Planning-vigentra.
- [x] Audit en lecture seule documenté.
- [ ] Tests avec comptes responsable et agent, et vérification réelle des droits RLS.
- [x] Feuille de route et contrôles de sécurité documentés.
- [ ] Audit fonctionnel complet de la version actuellement publiée.
- [ ] Validation des règles métier, tests avec comptes de test et sauvegarde.
- [ ] Intégration progressive après validation explicite.
