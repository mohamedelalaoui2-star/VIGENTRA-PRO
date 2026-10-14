# VIGENTRA PRO — démarrage sur iPhone

## Fichiers
- `index.html` : application web responsive, interface française noir / bleu nuit / rouge.
- `supabase.sql` : tables, déclencheur d'inscription et politiques de sécurité RLS.

## 1. Créer la base Supabase
1. Ouvrez https://supabase.com et créez un projet (l'offre gratuite suffit pour commencer, dans ses limites).
2. Dans **SQL Editor**, collez le contenu complet de `supabase.sql`, puis exécutez-le.
3. Dans **Project Settings > API**, copiez l'URL du projet et la clé publique `anon` / `publishable`. Ne partagez jamais la clé `service_role`.

## 2. Configurer le site
1. Ouvrez `index.html` dans un éditeur de texte (ou modifiez le fichier dans GitHub).
2. En bas du fichier, repérez :
   `const SUPABASE_URL = "COLLE_ICI_URL_SUPABASE";`
   `const SUPABASE_ANON_KEY = "COLLE_ICI_CLE_PUBLIQUE_SUPABASE";`
3. Remplacez les textes entre guillemets par l'URL et la clé publique du projet.
4. Enregistrez le fichier.

## 3. Publier gratuitement
Méthode recommandée si vous avez déjà un dépôt GitHub :
1. Ajoutez `index.html` à la racine du dépôt (et le fichier `supabase.sql` pour garder le schéma).
2. Dans GitHub, ouvrez **Settings > Pages**.
3. Choisissez **Deploy from a branch**, branche `main`, dossier `/ (root)`, puis **Save**.
4. Attendez l'URL GitHub Pages affichée par GitHub. La publication peut prendre quelques minutes.
5. Ouvrez l'URL dans Safari sur iPhone. Partager > **Sur l'écran d'accueil**.

## 4. Créer le compte responsable
1. Ouvrez le site publié et créez votre compte via « Créer un compte ».
2. Dans Supabase > **Authentication > Users**, copiez l'UUID de ce compte.
3. Dans **SQL Editor**, exécutez, en remplaçant l'UUID :
   `update public.profiles set role='manager', full_name='Responsable VIGENTRA' where id='UUID_DU_RESPONSABLE';`
4. Déconnectez-vous puis reconnectez-vous.
5. Les nouveaux comptes commencent avec le rôle `agent`. Le responsable peut associer une fiche agent à un profil en renseignant `profile_id` depuis Supabase.

## Fonctions incluses
- Connexion e-mail / mot de passe.
- Tableau de bord et alertes simples.
- Gestion des agents, sites, vacations, pointages et factures.
- Affectation des agents aux vacations.
- Export CSV des vacations.
- Rapport opérationnel local sans API IA payante.
- Impression de prévisualisation de facture.

## Limites importantes avant usage réel
- Ce projet est un socle fonctionnel de démarrage, pas encore un logiciel de paie ou de comptabilité certifié.
- Les factures générées sont une prévisualisation simple : compléter les mentions légales, la TVA, les conditions de règlement et les obligations françaises applicables. La facturation électronique évolue ; faites valider le processus avant émission officielle.
- Les profils et rôles doivent être administrés soigneusement. Le rôle responsable est promu manuellement via SQL afin d'éviter qu'un utilisateur se donne lui-même les droits.
- La clé publique Supabase est prévue pour le navigateur ; la sécurité repose sur les politiques RLS. N'ajoutez jamais de clé secrète/service-role au fichier.
- Le pointage web n'est pas une preuve inviolable de présence (un agent peut changer l'heure de son appareil ou faire un pointage hors site). Pour du contrôle renforcé, prévoir des contrôles côté serveur, journaux d'audit et éventuellement QR code géolocalisé avec information/consentement appropriés.
- Les calculs d'heures affichés sont indicatifs ; les vacations de nuit et les pauses nécessitent des règles métier supplémentaires.
- Aucune IA générative externe n'est appelée : l'assistant inclus calcule des alertes et un rapport local sans coût d'API.
