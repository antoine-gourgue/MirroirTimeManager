<template>
  <div class="flex justify-center items-center h-screen bg-gray-100">
    <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-md">
      <h2 class="text-2xl font-semibold text-center mb-4">Connexion</h2>
      <form @submit.prevent="login" class="space-y-4">
        <input
            v-model="user.email"
            placeholder="Email"
            class="border rounded w-full p-2"
            required
        />
        <input
            v-model="user.username"
            placeholder="Nom d'utilisateur"
            class="border rounded w-full p-2"
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
import { getUserByEmailAndUsername } from '../services/userService';

const user = ref({
  email: '',
  username: '',
  admin: ''
});

const error = ref('');
const router = useRouter();

async function login() {
  try {
    const response = await getUserByEmailAndUsername(user.value.email, user.value.username);
    const userData = response.data;

    localStorage.setItem('userId', userData.id);
    localStorage.setItem('isAdmin', userData.admin);

    await router.push('/');
  } catch (err) {
    error.value = 'Email ou nom d’utilisateur incorrect';
    console.error(err);
  }
}
</script>
