<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gérer une période de travail</h2>
    <form @submit.prevent="createWorkingTime" class="space-y-4">
      <input
          v-model="workingTime.start"
          placeholder="Début (YYYY-MM-DD hh:mm:ss)"
          class="border rounded w-full p-2"
      />
      <input
          v-model="workingTime.end"
          placeholder="Fin (YYYY-MM-DD hh:mm:ss)"
          class="border rounded w-full p-2"
      />
      <button
          type="submit"
          class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600"
      >
        Créer une période de travail
      </button>
    </form>
    <div class="mt-4 space-x-4">
      <button @click="updateWorkingTime" class="bg-yellow-500 text-white py-2 px-4 rounded hover:bg-yellow-600">
        Mettre à jour
      </button>
      <button @click="deleteWorkingTime" class="bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600">
        Supprimer
      </button>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue';
import { createWorkingTimeAPI, updateWorkingTimeAPI, deleteWorkingTimeAPI } from '../services/workingTimeService'; // Import des services API
import { ref } from 'vue';

const workingTime = reactive({
  start: '',
  end: '',
  id: null, // Ajoute l'ID pour les mises à jour et les suppressions
});

const userId = ref(localStorage.getItem('userId')); // Récupération de l'ID utilisateur

async function createWorkingTime() {
  try {
    const response = await createWorkingTimeAPI(userId.value, workingTime);
    console.log('Période de travail créée:', response.data);
    workingTime.id = response.data.data.id; // Stocker l'ID pour les futures mises à jour ou suppressions
  } catch (error) {
    console.error('Erreur lors de la création de la période de travail:', error);
  }
}

async function updateWorkingTime() {
  if (workingTime.id) {
    try {
      const response = await updateWorkingTimeAPI(workingTime.id, workingTime);
      console.log('Période de travail mise à jour:', response.data);
    } catch (error) {
      console.error('Erreur lors de la mise à jour de la période de travail:', error);
    }
  } else {
    console.error('Aucune période de travail sélectionnée pour la mise à jour.');
  }
}

async function deleteWorkingTime() {
  if (workingTime.id) {
    try {
      await deleteWorkingTimeAPI(workingTime.id);
      console.log('Période de travail supprimée');
      workingTime.start = '';
      workingTime.end = '';
      workingTime.id = null;
    } catch (error) {
      console.error('Erreur lors de la suppression de la période de travail:', error);
    }
  } else {
    console.error('Aucune période de travail sélectionnée pour la suppression.');
  }
}
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
