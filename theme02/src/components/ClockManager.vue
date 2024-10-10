<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gestion des horloges</h2>

    <p class="mb-4">
      Horloge actuelle :
      <span :class="clockIn ? 'text-green-500' : 'text-red-500'">
        {{ clockIn ? 'En cours' : 'Pas en cours' }}
      </span>
    </p>

    <div v-if="clockIn" class="flex justify-center items-center my-4">
      <p class="text-4xl font-bold text-green-500 animate-pulse">
        {{ timerDisplay }}
      </p>
    </div>

    <button @click="clock"
            class="bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600 transition duration-300 transform hover:scale-105">
      {{ clockIn ? 'Fin de travail' : 'Début de travail' }}
    </button>

    <div v-if="errorMessage" class="mt-4 bg-red-100 text-red-700 p-3 rounded">
      {{ errorMessage }}
    </div>

    <div v-if="successMessage" class="mt-4 bg-green-100 text-green-700 p-3 rounded">
      {{ successMessage }}
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { clockInAPI, clockOutAPI, getCurrentClockStatusAPI } from '../services/clockService';
import { createWorkingTime } from '../services/workingTimeService';

const clockIn = ref(false);
const userId = localStorage.getItem('userId');
const startTime = ref(null);
const timer = ref(0);
let timerInterval = null;
const router = useRouter();

const errorMessage = ref('');
const successMessage = ref('');

const timerDisplay = ref("00:00:00");

function formatTime(seconds) {
  const h = Math.floor(seconds / 3600).toString().padStart(2, '0');
  const m = Math.floor((seconds % 3600) / 60).toString().padStart(2, '0');
  const s = Math.floor(seconds % 60).toString().padStart(2, '0');
  return `${h}:${m}:${s}`;
}

function startTimer() {
  timerInterval = setInterval(() => {
    timer.value++;
    timerDisplay.value = formatTime(timer.value);
  }, 1000);
}

function stopTimer() {
  clearInterval(timerInterval);
  timer.value = 0;
  timerDisplay.value = "00:00:00";
}

function hideMessages() {
  setTimeout(() => {
    errorMessage.value = '';
    successMessage.value = '';
  }, 5000);
}

async function clock() {
  try {
    if (clockIn.value) {
      await clockOut();
      stopTimer();
      successMessage.value = 'Fin du travail enregistrée avec succès.';
      hideMessages();
    } else {
      await clockInAction();
      startTimer();
      successMessage.value = 'Début du travail enregistré avec succès.';
      hideMessages();
    }
    clockIn.value = !clockIn.value;
  } catch (error) {
    console.error('Erreur lors du changement d\'état de l\'horloge:', error);
    errorMessage.value = 'Une erreur est survenue lors du changement d\'état de l\'horloge.';
    hideMessages();
  }
}

async function clockInAction() {
  try {
    startTime.value = new Date();
    const response = await clockInAPI(userId);
    console.log('Travail commencé:', response.data);
    errorMessage.value = '';
  } catch (error) {
    errorMessage.value = 'Erreur lors du début du travail. Veuillez réessayer.';
    throw error;
  }
}

async function clockOut() {
  try {
    const endTime = new Date();
    const response = await clockOutAPI(userId);
    console.log('Travail terminé:', response.data);

    await createWorkingTime({
      user_id: userId,
      start: startTime.value.toISOString(),
      end: endTime.toISOString()
    });
    console.log('Période de travail créée:', startTime.value, endTime);
    errorMessage.value = '';
  } catch (error) {
    errorMessage.value = 'Erreur lors de la fin du travail. Veuillez réessayer.';
    throw error;
  }
}

onMounted(async () => {
  try {
    const response = await getCurrentClockStatusAPI(userId);
    clockIn.value = response.data.status;
  } catch (error) {
    errorMessage.value = 'Erreur lors de la récupération de l\'état actuel de l\'horloge.';
    console.error('Erreur lors du chargement de l\'état actuel de l\'horloge:', error);
  }
});
</script>

