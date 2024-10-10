<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gérer une période de travail</h2>

    <!-- Input pour l'ID utilisateur -->
    <input
        v-model="userId"
        placeholder="ID utilisateur"
        class="border rounded w-full p-2 mb-4"
    />

    <form @submit.prevent="createWorkingTime" class="space-y-4">
      <!-- Sélection du début de la période -->
      <label class="block mb-2">Début de la période :</label>
      <flat-pickr
          v-model="workingTime.start"
          :config="dateTimeConfig"
          class="border rounded w-full p-2"
          placeholder="Sélectionnez le début"
      />

      <!-- Sélection de la fin de la période -->
      <label class="block mt-4 mb-2">Fin de la période :</label>
      <flat-pickr
          v-model="workingTime.end"
          :config="dateTimeConfig"
          class="border rounded w-full p-2"
          placeholder="Sélectionnez la fin"
      />

      <!-- Bouton pour soumettre -->
      <button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600 mt-4">
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

    <!-- Afficher les messages d'alerte -->
    <div v-if="alertMessage" :class="alertClass" class="mt-4 p-4 rounded">
      {{ alertMessage }}
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import FlatPickr from 'vue-flatpickr-component';
import 'flatpickr/dist/flatpickr.css'; // Style de Flatpickr
import { createWorkingTimeAPI, updateWorkingTimeAPI, deleteWorkingTimeAPI } from '../services/workingTimeService';

// Initialisation de la période de travail
const workingTime = reactive({
  start: '',
  end: '',
  id: null,
});

// ID utilisateur
const userId = ref('');

// Configuration du calendrier pour Flatpickr (date et heure)
const dateTimeConfig = {
  enableTime: true,
  dateFormat: 'Y-m-d H:i:S', // Format pour année-mois-jour heure:minute:seconde
  time_24hr: true,
};

// Gestion des messages d'alerte
const alertMessage = ref('');
const alertClass = ref('');

// Fonction pour créer une période de travail
async function createWorkingTime() {
  if (!userId.value) {
    setAlert('Veuillez entrer un ID utilisateur.', 'bg-red-500 text-white');
    return;
  }

  try {
    const response = await createWorkingTimeAPI(userId.value, workingTime);
    console.log('Période de travail créée:', response.data);
    workingTime.id = response.data.data.id; // Stocker l'ID pour les futures mises à jour ou suppressions
    setAlert('Période de travail créée avec succès.', 'bg-green-500 text-white');
  } catch (error) {
    console.error('Erreur lors de la création de la période de travail:', error);
    setAlert('Erreur lors de la création de la période de travail.', 'bg-red-500 text-white');
  }
}

// Fonction pour mettre à jour la période de travail
async function updateWorkingTime() {
  if (workingTime.id) {
    try {
      const response = await updateWorkingTimeAPI(workingTime.id, workingTime);
      console.log('Période de travail mise à jour:', response.data);
      setAlert('Période de travail mise à jour avec succès.', 'bg-green-500 text-white');
    } catch (error) {
      console.error('Erreur lors de la mise à jour de la période de travail:', error);
      setAlert('Erreur lors de la mise à jour de la période de travail.', 'bg-red-500 text-white');
    }
  } else {
    setAlert('Aucune période de travail sélectionnée pour la mise à jour.', 'bg-red-500 text-white');
  }
}

// Fonction pour supprimer une période de travail
async function deleteWorkingTime() {
  if (workingTime.id) {
    try {
      await deleteWorkingTimeAPI(workingTime.id);
      console.log('Période de travail supprimée');
      workingTime.start = '';
      workingTime.end = '';
      workingTime.id = null;
      setAlert('Période de travail supprimée avec succès.', 'bg-green-500 text-white');
    } catch (error) {
      console.error('Erreur lors de la suppression de la période de travail:', error);
      setAlert('Erreur lors de la suppression de la période de travail.', 'bg-red-500 text-white');
    }
  } else {
    setAlert('Aucune période de travail sélectionnée pour la suppression.', 'bg-red-500 text-white');
  }
}

// Fonction pour définir un message d'alerte
function setAlert(message, cssClass) {
  alertMessage.value = message;
  alertClass.value = cssClass;

  // Supprimer l'alerte après 5 secondes
  setTimeout(() => {
    alertMessage.value = '';
    alertClass.value = '';
  }, 5000);
}
</script>

<style scoped>
/* Styles spécifiques à ce composant */
</style>
