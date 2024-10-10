<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Liste des utilisateurs</h2>
    <table class="min-w-full bg-white">
      <thead class="bg-gray-100">
      <tr>
        <th class="text-left py-2 px-4">ID</th>
        <th class="text-left py-2 px-4">Nom d'utilisateur</th>
        <th class="text-left py-2 px-4">Email</th>
        <th class="text-left py-2 px-4">Admin</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="user in users" :key="user.id" class="hover:bg-gray-100">
        <td class="py-2 px-4">{{ user.id }}</td>
        <td class="py-2 px-4">{{ user.username }}</td>
        <td class="py-2 px-4">{{ user.email }}</td>
        <td class="py-2 px-4">{{ user.admin ? 'Oui' : 'Non' }}</td>
      </tr>
      </tbody>
    </table>
    <p v-if="users.length === 0" class="mt-4 text-red-500">Aucun utilisateur trouvé.</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { getUsers } from '../services/userService.js';

const users = ref([]);

async function fetchUsers() {
  try {
    const response = await getUsers();
    users.value = response.data.data;
  } catch (error) {
    console.error('Erreur lors de la récupération des utilisateurs :', error);
  }
}

onMounted(() => {
  fetchUsers();
});
</script>
