<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gérer une période de travail</h2>
    <form @submit.prevent="createWorkingTime" class="space-y-4">
      <input v-model="workingTime.start" placeholder="Début (YYYY-MM-DD hh:mm:ss)" class="border rounded w-full p-2" />
      <input v-model="workingTime.end" placeholder="Fin (YYYY-MM-DD hh:mm:ss)" class="border rounded w-full p-2" />
      <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
        Créer une période de travail
      </button>
    </form>
    <div class="mt-4 space-x-4">
      <button @click="updateWorkingTime" class="bg-yellow-500 text-white py-2 px-4 rounded hover:bg-yellow-600">Mettre à jour</button>
      <button @click="deleteWorkingTime" class="bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600">Supprimer</button>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue';

const workingTime = reactive({
  start: '',
  end: '',
});

function createWorkingTime() {
  console.log('Création d\'une période de travail');
}

function updateWorkingTime() {
  console.log('Mise à jour de la période de travail');
}

function deleteWorkingTime() {
  console.log('Suppression de la période de travail');
}
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
