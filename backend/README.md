
# TimeManager API

API pour gérer les utilisateurs, équipes, rôles, horloges, temps de travail, et logs d'audit d'un système de gestion de temps.

## Prérequis

- **Elixir** et **Phoenix Framework**
- **PostgreSQL** pour la base de données
- **Postman** (ou autre outil API REST) pour tester les requêtes

## Installation

1. **Clonez le dépôt** :
   ```bash
   git clone https://github.com/votre-repository/timemanager.git
   cd timemanager
   ```

2. **Installez les dépendances** :
   ```bash
   mix deps.get
   ```

3. **Configurez la base de données** dans `config/dev.exs`, puis créez-la :
   ```bash
   mix ecto.create
   mix ecto.migrate
   ```

4. **Lancez le serveur Phoenix** :
   ```bash
   mix phx.server
   ```

5. **Importez la collection Postman** (fichier fourni) pour accéder aux routes de l'API.

---

## Structure de l'API

Toutes les routes sont accessibles sous le préfixe `/api`.

### Authentification

#### Login
- **Méthode** : `POST`
- **URL** : `/api/login`
- **Description** : Authentification de l'utilisateur.
- **Body** :
  ```json
  {
      "email": "johndoe@example.com",
      "password": "secret"
  }
  ```

### Utilisateurs

#### Liste des utilisateurs
- **Méthode** : `GET`
- **URL** : `/api/users`
- **Description** : Récupère la liste de tous les utilisateurs.

#### Créer un utilisateur
- **Méthode** : `POST`
- **URL** : `/api/users`
- **Description** : Crée un nouvel utilisateur.
- **Body** :
  ```json
  {
      "user": {
          "email": "newuser@example.com",
          "username": "newuser",
          "password": "password123"
      }
  }
  ```

#### Obtenir un utilisateur par ID
- **Méthode** : `GET`
- **URL** : `/api/users/:id`
- **Description** : Récupère un utilisateur par son ID.

#### Mettre à jour un utilisateur
- **Méthode** : `PUT`
- **URL** : `/api/users/:id`
- **Description** : Met à jour les informations d'un utilisateur.
- **Body** :
  ```json
  {
      "user": {
          "email": "updated@example.com",
          "username": "updateduser"
      }
  }
  ```

#### Supprimer un utilisateur
- **Méthode** : `DELETE`
- **URL** : `/api/users/:id`
- **Description** : Supprime un utilisateur par son ID.

### Équipes

#### Liste des équipes
- **Méthode** : `GET`
- **URL** : `/api/teams`
- **Description** : Récupère la liste de toutes les équipes.

#### Créer une équipe
- **Méthode** : `POST`
- **URL** : `/api/teams`
- **Description** : Crée une nouvelle équipe.
- **Body** :
  ```json
  {
      "team": {
          "name": "Team A",
          "manager_id": 1
      }
  }
  ```

#### Obtenir une équipe par ID
- **Méthode** : `GET`
- **URL** : `/api/teams/:id`
- **Description** : Récupère une équipe par son ID.

#### Mettre à jour une équipe
- **Méthode** : `PUT`
- **URL** : `/api/teams/:id`
- **Description** : Met à jour les informations d'une équipe.
- **Body** :
  ```json
  {
      "team": {
          "name": "Updated Team Name",
          "manager_id": 2
      }
  }
  ```

#### Supprimer une équipe
- **Méthode** : `DELETE`
- **URL** : `/api/teams/:id`
- **Description** : Supprime une équipe par son ID.

### Rôles

#### Liste des rôles
- **Méthode** : `GET`
- **URL** : `/api/roles`
- **Description** : Récupère la liste de tous les rôles.

#### Créer un rôle
- **Méthode** : `POST`
- **URL** : `/api/roles`
- **Description** : Crée un nouveau rôle.
- **Body** :
  ```json
  {
      "role": {
          "name": "Manager"
      }
  }
  ```

#### Supprimer un rôle
- **Méthode** : `DELETE`
- **URL** : `/api/roles/:id`
- **Description** : Supprime un rôle par son ID.

### Clocks

#### Liste des horloges
- **Méthode** : `GET`
- **URL** : `/api/clocks`
- **Description** : Récupère toutes les horloges.

#### Créer une horloge
- **Méthode** : `POST`
- **URL** : `/api/clocks`
- **Description** : Crée une nouvelle entrée d'horloge (Clock-in / Clock-out).
- **Body** :
  ```json
  {
      "clock": {
          "status": "IN",
          "time": "2024-10-25T08:00:00Z",
          "user_id": 1
      }
  }
  ```

### Temps de travail

#### Liste des temps de travail
- **Méthode** : `GET`
- **URL** : `/api/working_times`
- **Description** : Récupère tous les temps de travail.

#### Créer un temps de travail
- **Méthode** : `POST`
- **URL** : `/api/working_times`
- **Description** : Crée un nouveau temps de travail.
- **Body** :
  ```json
  {
      "working_time": {
          "type": "work",
          "start_time": "2024-10-25T08:00:00Z",
          "end_time": "2024-10-25T17:00:00Z",
          "user_id": 1
      }
  }
  ```

### Logs d'audit

#### Liste des logs d'audit
- **Méthode** : `GET`
- **URL** : `/api/audit_logs`
- **Description** : Récupère tous les logs d'audit.

---

## Authentification

L'authentification est requise pour accéder aux routes protégées. Utilisez le token JWT dans le header `Authorization` pour chaque requête.
