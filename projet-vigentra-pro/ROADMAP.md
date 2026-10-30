# Feuille de route VIGENTRA PRO

## P0 — Fiabilité et sécurité avant usage réel
- Confirmer quel projet Supabase est la source de vérité et vérifier son statut.
- Cartographier tables, colonnes, contraintes, triggers, rôles et politiques RLS.
- Tester connexion, déconnexion, session expirée, erreurs réseau et configuration manquante.
- Vérifier que les agents ne peuvent ni consulter les dossiers des autres, ni modifier leur rôle.
- Vérifier l’isolation des données entre organisations si l’application doit héberger plusieurs sociétés.
- Créer et tester une procédure de sauvegarde/restauration avant toute migration.
- Corriger les erreurs d’affichage et d’export sur Safari iPhone.

## P1 — Planning et couverture opérationnelle
- Vue jour/semaine/mois, navigation par date et filtres par site/agent.
- Créer, modifier, annuler et dupliquer une vacation.
- Vérifier les chevauchements, repos et doubles affectations.
- Contrôler les qualifications exigées par le poste (APS, SSIAP, SST, etc.) et leur validité.
- Alerter sur les vacations sans agent, les remplacements et les absences.
- Distinguer heures planifiées, pointées et validées.

## P1 — Dossiers et conformité des agents
- Fiche agent avec coordonnées nécessaires, statut, qualifications et dates d’expiration.
- Alertes configurables à 60, 30 et 7 jours.
- Historique des changements sensibles et accès par rôle.
- Ne conserver que les documents nécessaires, limiter les accès et définir une durée de conservation.

## P2 — Pointage et suivi
- Prise et fin de service liées à une vacation.
- Contrôles serveur sur les transitions et horodatages.
- Écart entre horaire prévu et réel, justification et validation responsable.
- Mode hors ligne uniquement après conception d’une synchronisation sans doublons.
- GPS/QR uniquement si besoin établi, information claire, base légale et protection des données appropriées.

## P2 — Clients, contrats et rentabilité
- Fiches clients, sites, contacts professionnels et contrats.
- Tarifs, volumes prévus, heures réalisées, facturation préparatoire et règlements.
- Estimation de marge avec paramètres explicites et coûts modifiables.
- Factures officielles à valider au regard des obligations françaises et de la facturation électronique.

## P3 — Exports, alertes et confort
- PDF imprimable avec identité visuelle, CSV et partage iOS.
- Alertes in-app ; e-mail/push uniquement après vérification des possibilités gratuites et des autorisations.
- Sauvegarde exportable, contrôle d’intégrité et confirmation avant restauration.
- Interface accessible : grandes zones tactiles, contraste, navigation clavier, messages d’erreur explicites.

## Critères de sortie avant chaque version
- Tests fonctionnels réussis.
- Tests RLS réussis avec au moins deux comptes distincts.
- Aucun secret dans le code navigateur ou les journaux.
- Export contrôlé sur iPhone et ordinateur.
- Sauvegarde vérifiée.
- Pas de migration ou déploiement automatique sans validation.
