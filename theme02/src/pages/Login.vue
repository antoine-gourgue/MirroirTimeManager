<template>
  <div class="flex justify-center items-center h-screen bg-gray-100">
    <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-md">
      <h2 class="text-2xl font-semibold text-center mb-4">Connexion</h2>
      <form @submit.prevent="login" class="space-y-4">
        <input
            v-model="user.email"
            placeholder="Email"
            class="border p-2"
        required
        />
        <input
            v-model="user.username"
            placeholder="Nom d'utilisateur"
            class="border p-2"
        required
        />
        <button
            type="submit"
            class="w-full bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
        >
          Se connecter
        </button>
      </form>
      <p v-if="error" class="text-red-500 text-center mt-4">{{ error }}</p>
    </div>
  </div>
</template>


<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { getUserByEmailAndUsername } from '../services/userService.js';

const user = ref({
  email: '',
  username: ''
});

const error = ref('');
const router = useRouter();

async function login() {
  try {
    console.log('Login attempt:', user.value); // Debugging log
    // Appel à l'API avec email et username
    const response = await getUserByEmailAndUsername(user.value.email, user.value.username);
    console.log('API response:', response); // Debugging log

    const userData = response.data.data;
    console.log('User data:', userData); // Debugging log

    // Stockage de l'ID dans le localStorage
    localStorage.setItem('userId', userData.id);

    // Redirection vers la page principale après la connexion
    await router.push('/');
  } catch (err) {
    error.value = 'Email ou nom d’utilisateur incorrect';
    console.error('Login error:', err); // Debugging log
  }
}
</script>


<style scoped>
/* Styles spécifiques à la page de connexion */
</style>

