<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Périodes de travail</h2>
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
import { ref, onMounted } from 'vue';
import { getWorkingTimes } from '../services/workingTimeService'; // Assurez-vous que cette fonction est correcte

const workingTimes = ref([]);

// Fonction pour récupérer les périodes de travail depuis l'API
async function loadWorkingTimes() {
  try {
    const userId = localStorage.getItem('userId');
    const response = await getWorkingTimes(userId);
    workingTimes.value = response.data.data; // Charger les périodes de travail dans l'état
  } catch (error) {
    console.error('Erreur lors de la récupération des périodes de travail :', error);
  }
}

// Formater les dates pour un affichage plus lisible
function formatDate(dateStr) {
  const options = { year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
  return new Date(dateStr).toLocaleDateString(undefined, options);
}

// Charger les données au montage du composant
onMounted(() => {
  loadWorkingTimes();
});
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
