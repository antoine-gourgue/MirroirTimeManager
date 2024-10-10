<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Informations de l'utilisateur</h2>

    <div class="mb-4">
      <p class="text-gray-700 mb-2">
        <strong class="font-semibold">ID :</strong> {{ user.id }}
      </p>
      <p class="text-gray-700 mb-2">
        <strong class="font-semibold">Nom d'utilisateur :</strong> {{ user.username }}
      </p>
      <p class="text-gray-700">
        <strong class="font-semibold">Email :</strong> {{ user.email }}
      </p>
    </div>

    <button
        @click="logout"
        class="bg-red-500 text-white py-2 px-4 rounded-lg hover:bg-red-600 transition duration-300 transform hover:scale-105"
    >
      Déconnexion
    </button>

  </div>
</template>

<script setup>
import {ref, onMounted} from 'vue';
import {useRouter} from 'vue-router';
import {getUserById} from '../services/userService';

const router = useRouter();
const user = ref({
  id: '',
  username: '',
  email: ''
});

const errorMessage = ref('');
const successMessage = ref('');

function hideMessages() {
  setTimeout(() => {
    errorMessage.value = '';
    successMessage.value = '';
  }, 5000);
}

async function loadUser() {
  try {
    const userId = localStorage.getItem('userId');
    const response = await getUserById(userId);
    user.value = response.data;
  } catch (error) {

  }
}

function logout() {
  localStorage.clear();
  router.push('/login');
}

onMounted(() => {
  loadUser();
});
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
