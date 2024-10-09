<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gestion des horloges</h2>
    <p class="mb-4">Horloge actuelle : <span :class="clockIn ? 'text-green-500' : 'text-red-500'">{{ clockIn ? 'En cours' : 'Pas en cours' }}</span></p>
    <button @click="clock" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
      {{ clockIn ? 'Fin de travail' : 'Début de travail' }}
    </button>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const clockIn = ref(false);

function clock() {
  clockIn.value = !clockIn.value;
  console.log(clockIn.value ? 'Début du travail' : 'Fin du travail');
}
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
