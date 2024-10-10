<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gestion de l'utilisateur</h2>
    <form @submit.prevent="createUser" class="space-y-4">
      <input v-model="user.username" placeholder="Nom d'utilisateur" class="border rounded w-full p-2" />
      <input v-model="user.email" placeholder="Email" class="border rounded w-full p-2" />
      <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
        Créer l'utilisateur
      </button>
    </form>
    <div class="mt-4 space-x-4">
      <button @click="getUser" class="bg-green-500 text-white py-2 px-4 rounded hover:bg-green-600">Afficher</button>
      <button @click="updateUser" class="bg-yellow-500 text-white py-2 px-4 rounded hover:bg-yellow-600">Mettre à jour</button>
      <button @click="deleteUser" class="bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600">Supprimer</button>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue';
import { createUser as createUserService, getUserById, updateUser as updateUserService, deleteUser as deleteUserService } from '../services/userService.js';

// Utilisation d'un état réactif pour stocker les données de l'utilisateur
const user = reactive({
  id: '', // Id de l'utilisateur, à renseigner si nécessaire
  username: '',
  email: '',
});

// Fonction pour créer un utilisateur
async function createUser() {
  try {
    const response = await createUserService(user);
    user.id = response.data.id; // Mise à jour de l'id après la création
    alert('Utilisateur créé avec succès');
  } catch (error) {
    console.error('Erreur lors de la création de l\'utilisateur :', error);
    alert('Erreur lors de la création de l\'utilisateur');
  }
}

// Fonction pour récupérer un utilisateur par son id
async function getUser() {
  if (!user.id) {
    alert('Veuillez renseigner un ID d\'utilisateur');
    return;
  }

  try {
    const response = await getUserById(user.id);
    user.username = response.data.username;
    user.email = response.data.email;
    alert('Utilisateur récupéré avec succès');
  } catch (error) {
    console.error('Erreur lors de la récupération de l\'utilisateur :', error);
    alert('Erreur lors de la récupération de l\'utilisateur');
  }
}

// Fonction pour mettre à jour un utilisateur
async function updateUser() {
  if (!user.id) {
    alert('Veuillez renseigner un ID d\'utilisateur');
    return;
  }

  try {
    await updateUserService(user.id, { username: user.username, email: user.email });
    alert('Utilisateur mis à jour avec succès');
  } catch (error) {
    console.error('Erreur lors de la mise à jour de l\'utilisateur :', error);
    alert('Erreur lors de la mise à jour de l\'utilisateur');
  }
}

// Fonction pour supprimer un utilisateur
async function deleteUser() {
  if (!user.id) {
    alert('Veuillez renseigner un ID d\'utilisateur');
    return;
  }

  try {
    await deleteUserService(user.id);
    // Réinitialiser les données après suppression
    user.id = '';
    user.username = '';
    user.email = '';
    alert('Utilisateur supprimé avec succès');
  } catch (error) {
    console.error('Erreur lors de la suppression de l\'utilisateur :', error);
    alert('Erreur lors de la suppression de l\'utilisateur');
  }
}
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
