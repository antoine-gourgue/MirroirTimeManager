<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Périodes de travail</h2>

    <div class="mb-4">
      <input v-model="userId" placeholder="Entrez l'ID utilisateur" class="border rounded w-full p-2 mb-2" />
      <button @click="loadWorkingTimes" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
        Rechercher les périodes de travail
      </button>
    </div>

    <table class="min-w-full bg-white">
      <thead class="bg-gray-100">
      <tr>
        <th class="text-left py-2 px-4">ID</th>
        <th class="text-left py-2 px-4">Début</th>
        <th class="text-left py-2 px-4">Fin</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="workingTime in workingTimes" :key="workingTime.id" class="hover:bg-gray-100">
        <td class="py-2 px-4">{{ workingTime.id }}</td>
        <td class="py-2 px-4">{{ formatDate(workingTime.start) }}</td>
        <td class="py-2 px-4">{{ formatDate(workingTime.end) }}</td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { getWorkingTimes } from '../services/workingTimeService';
const workingTimes = ref([]);
const userId = ref('');

async function loadWorkingTimes() {
  if (!userId.value) {
    alert('Veuillez entrer un ID utilisateur');
    return;
  }

  try {
    const response = await getWorkingTimes(userId.value);
    workingTimes.value = response.data.data;
  } catch (error) {
    console.error('Erreur lors de la récupération des périodes de travail :', error);
  }
}

function formatDate(dateStr) {
  const options = { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
  return new Date(dateStr).toLocaleDateString(undefined, options);
}
</script>

