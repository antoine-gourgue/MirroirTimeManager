<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gestion des horloges</h2>
    <p class="mb-4">Horloge actuelle :
      <span :class="clockIn ? 'text-green-500' : 'text-red-500'">
        {{ clockIn ? 'En cours' : 'Pas en cours' }}
      </span>
    </p>
    <button @click="clock" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
      {{ clockIn ? 'Fin de travail' : 'Début de travail' }}
    </button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { clockInAPI, clockOutAPI, getCurrentClockStatusAPI } from '../services/clockService';
import {createWorkingTime, createWorkingTimeAPI} from '../services/workingTimeService';

const clockIn = ref(false); // État de l'horloge
const userId = localStorage.getItem('userId'); // Récupérer l'ID utilisateur stocké dans le localStorage
const startTime = ref(null); // Stocker l'heure de début du travail
const router = useRouter();

// Fonction pour gérer le début et la fin de travail
async function clock() {
  if (clockIn.value) {
    // Appeler l'API pour marquer la fin de travail
    await clockOut();
  } else {
    // Appeler l'API pour marquer le début de travail
    await clockInAction();
  }
  clockIn.value = !clockIn.value; // Changer l'état local après l'action
}

// Appeler l'API pour marquer le début de travail
async function clockInAction() {
  try {
    startTime.value = new Date(); // Enregistrer l'heure de début
    const response = await clockInAPI(userId);
    console.log('Travail commencé:', response.data);
  } catch (error) {
    console.error('Erreur lors du début de travail:', error);
  }
}

// Appeler l'API pour marquer la fin de travail
async function clockOut() {
  try {
    const endTime = new Date(); // Heure de fin
    const response = await clockOutAPI(userId);
    console.log('Travail terminé:', response.data);

    // Créer une période de travail (workingTime) dans l'API
    await createWorkingTime({
      user_id: userId,
      start: startTime.value.toISOString(),
      end: endTime.toISOString()
    });
    console.log('Période de travail créée:', startTime.value, endTime);
  } catch (error) {
    console.error('Erreur lors de la fin de travail ou de la création de la période:', error);
  }
}

// Charger l'état actuel de l'horloge lors du montage du composant
onMounted(async () => {
  try {
    const response = await getCurrentClockStatusAPI(userId);
    clockIn.value = response.data.status; // Mettre à jour l'état en fonction de la réponse
  } catch (error) {
    console.error('Erreur lors du chargement de l\'état actuel de l\'horloge:', error);
  }
});
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
