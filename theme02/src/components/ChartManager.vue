<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gestion des graphiques</h2>
    <chart :data="chartData" type="bar" class="w-full"></chart>
  </div>
</template>

<script setup>
const chartData = {
  labels: ['Jour 1', 'Jour 2', 'Jour 3'],
  datasets: [
    {
      label: 'Heures travaillées',
      backgroundColor: '#f87979',
      data: [8, 7, 6],
    },
  ],
};
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
