# Sécurité et plan de tests

## Contrôles Supabase
- RLS activée sur chaque table contenant des données privées.
- Politiques minimales par opération (SELECT, INSERT, UPDATE, DELETE).
- Interdire à un utilisateur de s’attribuer le rôle dirigeant ou de modifier des champs privilégiés.
- Vérifier les fonctions `SECURITY DEFINER`, leur `search_path`, leurs permissions d’exécution et les risques de récursion RLS.
- Indexer les clés étrangères utilisées dans les politiques si nécessaire.
- Ne pas se fier aux filtres côté client : les autorisations doivent être imposées côté base.
- Ne jamais utiliser une clé `service_role` dans l’application web.
- Les erreurs affichées à l’utilisateur ne doivent pas exposer les secrets ni les détails internes.

## Scénarios fonctionnels
1. Une personne non connectée ne peut pas ouvrir les vues privées.
2. Un compte agent ne voit que ses propres vacations et pointages autorisés.
3. Un compte agent ne peut pas créer un dirigeant ni modifier son rôle.
4. Un dirigeant peut gérer les données de son périmètre uniquement.
5. Un utilisateur d’une autre société ne peut pas lire les données de TEA.
6. Un agent sans qualification valide ne peut pas être affecté à une vacation qui l’exige, ou l’affectation affiche un blocage explicite.
7. Une vacation en conflit est signalée avant validation.
8. Les heures de nuit traversant minuit sont calculées selon une règle métier documentée.
9. Un échec réseau ne doit pas afficher à tort une opération comme réussie.
10. Les exports respectent les filtres choisis et ne contiennent pas les données d’autres utilisateurs.
11. Déconnexion et expiration de session retirent l’accès aux écrans privés.
12. Sauvegarde puis restauration de test reproduisent les données attendues sans doublons.

## Protection des données personnelles
- Définir qui peut accéder aux coordonnées et documents des agents.
- Ne pas collecter de localisation en continu par défaut.
- Définir les durées de conservation, droits d’accès et procédures de suppression.
- Informer les agents sur le pointage et les traitements associés.
- Faire valider les obligations légales applicables avant l’exploitation réelle.

## Procédure de changement
1. Exporter une sauvegarde.
2. Faire une modification ciblée et documentée.
3. Tester sur une copie ou un environnement de test.
4. Vérifier les permissions et les erreurs.
5. Obtenir une validation avant production.
6. Prévoir une procédure de retour arrière.
