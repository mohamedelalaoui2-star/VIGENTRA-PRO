# Modèle de données cible — proposition

Ce document n’est pas une migration SQL. Le schéma réel doit être inspecté avant d’ajouter ou de renommer des tables.

## Entités de base
- **profiles** : compte Auth, nom d’affichage et rôle contrôlé côté serveur.
- **organizations** : entreprise cliente de VIGENTRA si le multi-société est nécessaire.
- **organization_members** : association utilisateur/organisation/rôle.
- **agents** : fiche opérationnelle, qualifications et lien contrôlé vers un profil.
- **sites** : lieux d’affectation et consignes utiles, accès restreint.
- **clients** : contacts professionnels et informations contractuelles minimales.
- **contracts** : période, tarifs, volume prévu et conditions.
- **shifts** : site, agent affecté, début/fin prévus, exigences de qualification et statut.
- **time_entries** : événements de début/fin, auteur, horodatage serveur, justification et validation.
- **qualifications** : type, référence utile, dates d’obtention/expiration et statut de vérification.
- **invoices** : brouillons, montants, statut de règlement et références.
- **audit_logs** : actions sensibles, auteur, date et cible, sans stocker de secrets.

## Règles importantes
- Utiliser des identifiants UUID et des clés étrangères cohérentes.
- Stocker les dates en timestamptz ; afficher dans le fuseau horaire français.
- Valider `end_at > start_at` et documenter les vacations qui passent minuit.
- Séparer heures prévues, pointées, corrigées et validées.
- Conserver l’historique des corrections de pointage plutôt que d’effacer silencieusement.
- Ne pas stocker des documents sensibles en public ; utiliser un stockage privé avec règles d’accès.
- Pour une application multi-société, inclure un périmètre organisationnel et le vérifier dans chaque politique RLS.
- Les calculs financiers et de paie doivent être clairement marqués comme estimations tant que les règles ne sont pas validées.

## Migration
Aucune migration ne doit être lancée depuis ce document. Comparer d’abord cette cible aux tables existantes, préparer un script idempotent, sauvegarder, tester sur un environnement isolé et valider les résultats.
