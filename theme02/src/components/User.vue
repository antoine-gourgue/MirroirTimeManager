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

const user = reactive({
  username: '',
  email: '',
});

function createUser() {
  console.log('Création de l\'utilisateur');
}

function getUser() {
  console.log('Récupération de l\'utilisateur');
}

function updateUser() {
  console.log('Mise à jour de l\'utilisateur');
}

function deleteUser() {
  console.log('Suppression de l\'utilisateur');
}
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
