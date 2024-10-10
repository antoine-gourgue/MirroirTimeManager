<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gérer une période de travail</h2>

    <input
        v-model="userId"
        placeholder="ID utilisateur"
        class="border rounded w-full p-2 mb-4"
    />

    <form @submit.prevent="createWorkingTime" class="space-y-4">
      <label class="block mb-2">Début de la période :</label>
      <flat-pickr
          v-model="workingTime.start"
          :config="dateTimeConfig"
          class="border rounded w-full p-2"
          placeholder="Sélectionnez le début"
      />

      <label class="block mt-4 mb-2">Fin de la période :</label>
      <flat-pickr
          v-model="workingTime.end"
          :config="dateTimeConfig"
          class="border rounded w-full p-2"
          placeholder="Sélectionnez la fin"
      />

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

    <div v-if="alertMessage" :class="alertClass" class="mt-4 p-4 rounded">
      {{ alertMessage }}
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import FlatPickr from 'vue-flatpickr-component';
import 'flatpickr/dist/flatpickr.css';
import { createWorkingTimeAPI, updateWorkingTimeAPI, deleteWorkingTimeAPI } from '../services/workingTimeService';

const workingTime = reactive({
  start: '',
  end: '',
  id: null,
});

const userId = ref('');

const dateTimeConfig = {
  enableTime: true,
  dateFormat: 'Y-m-d H:i:S',
  time_24hr: true,
};

const alertMessage = ref('');
const alertClass = ref('');

async function createWorkingTime() {
  if (!userId.value) {
    setAlert('Veuillez entrer un ID utilisateur.', 'bg-red-500 text-white');
    return;
  }

  try {
    const response = await createWorkingTimeAPI(userId.value, workingTime);
    console.log('Période de travail créée:', response.data);
    workingTime.id = response.data.data.id;
    setAlert('Période de travail créée avec succès.', 'bg-green-500 text-white');
  } catch (error) {
    console.error('Erreur lors de la création de la période de travail:', error);
    setAlert('Erreur lors de la création de la période de travail.', 'bg-red-500 text-white');
  }
}

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

function setAlert(message, cssClass) {
  alertMessage.value = message;
  alertClass.value = cssClass;

  setTimeout(() => {
    alertMessage.value = '';
    alertClass.value = '';
  }, 5000);
}
</script>

