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
        <td class="py-2 px-4">{{ workingTime.start }}</td>
        <td class="py-2 px-4">{{ workingTime.end }}</td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const workingTimes = ref([]);

function getWorkingTimes() {
  console.log('Récupération des périodes de travail');
  workingTimes.value = [
    { id: 1, start: '2023-01-01 09:00:00', end: '2023-01-01 17:00:00' },
    { id: 2, start: '2023-01-02 09:00:00', end: '2023-01-02 17:00:00' },
  ];
}

onMounted(() => {
  getWorkingTimes();
});
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
