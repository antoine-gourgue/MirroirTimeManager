<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gestion de l'utilisateur</h2>

    <form @submit.prevent="createUser" class="space-y-4">
      <input v-model="user.username" placeholder="Nom d'utilisateur" class="border rounded w-full p-2" />
      <input v-model="user.email" placeholder="Email" class="border rounded w-full p-2" />

      <div class="flex items-center">
        <input v-model="user.admin" type="checkbox" id="admin" class="mr-2" />
        <label for="admin" class="text-gray-700">Admin</label>
      </div>

      <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
        Créer l'utilisateur
      </button>
    </form>

    <div class="mt-4 space-y-4">
      <input v-model="user.id" placeholder="ID de l'utilisateur" class="border rounded w-full p-2" />
      <div class="space-x-4">
        <button @click="getUser" class="bg-green-500 text-white py-2 px-4 rounded hover:bg-green-600">
          Afficher
        </button>
        <button @click="updateUser" class="bg-yellow-500 text-white py-2 px-4 rounded hover:bg-yellow-600">
          Mettre à jour
        </button>
        <button @click="deleteUser" class="bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600">
          Supprimer
        </button>
      </div>
    </div>

    <div v-if="alertMessage" :class="alertClass" class="mt-4 p-4 rounded">
      {{ alertMessage }}
    </div>
  </div>
</template>

<script setup>
import {reactive, ref} from 'vue';
import {
  createUser as createUserService,
  getUserById,
  updateUser as updateUserService,
  deleteUser as deleteUserService
} from '../services/userService.js';

const user = reactive({
  id: '',
  username: '',
  email: '',
  admin: false,
});

const alertMessage = ref('');
const alertClass = ref('');

function setAlert(message, type) {
  alertMessage.value = message;
  alertClass.value = type === 'success' ? 'bg-green-500 text-white' : 'bg-red-500 text-white';

  setTimeout(() => {
    alertMessage.value = '';
    alertClass.value = '';
  }, 5000);
}

async function createUser() {
  try {
    const response = await createUserService({
      username: user.username,
      email: user.email,
      admin: user.admin
    });
    user.id = response.data.id;
    setAlert('Utilisateur créé avec succès', 'success');
  } catch (error) {
    console.error('Erreur lors de la création de l\'utilisateur :', error);
    setAlert('Erreur lors de la création de l\'utilisateur', 'error');
  }
}

async function getUser() {
  if (!user.id) {
    setAlert('Veuillez renseigner un ID d\'utilisateur', 'error');
    return;
  }

  try {
    const response = await getUserById(user.id);
    user.username = response.data.username;
    user.email = response.data.email;
    user.admin = response.data.admin;
    setAlert('Utilisateur récupéré avec succès', 'success');
  } catch (error) {
    console.error('Erreur lors de la récupération de l\'utilisateur :', error);
    setAlert('Erreur lors de la récupération de l\'utilisateur', 'error');
  }
}

async function updateUser() {
  if (!user.id) {
    setAlert('Veuillez renseigner un ID d\'utilisateur', 'error');
    return;
  }

  try {
    await updateUserService(user.id, {
      username: user.username,
      email: user.email,
      admin: user.admin
    });
    setAlert('Utilisateur mis à jour avec succès', 'success');
  } catch (error) {
    console.error('Erreur lors de la mise à jour de l\'utilisateur :', error);
    setAlert('Erreur lors de la mise à jour de l\'utilisateur', 'error');
  }
}

async function deleteUser() {
  if (!user.id) {
    setAlert('Veuillez renseigner un ID d\'utilisateur', 'error');
    return;
  }

  try {
    await deleteUserService(user.id);
    user.id = '';
    user.username = '';
    user.email = '';
    user.admin = false;
    setAlert('Utilisateur supprimé avec succès', 'success');
  } catch (error) {
    console.error('Erreur lors de la suppression de l\'utilisateur :', error);
    setAlert('Erreur lors de la suppression de l\'utilisateur', 'error');
  }
}
</script>

