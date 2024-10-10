<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gestion des graphiques</h2>

    <button @click="reloadChart" class="mb-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
      Recharger le graphique
    </button>

    <div v-if="successMessage" class="mb-4 bg-green-100 text-green-700 p-3 rounded">
      {{ successMessage }}
    </div>
    <div v-if="errorMessage" class="mb-4 bg-red-100 text-red-700 p-3 rounded">
      {{ errorMessage }}
    </div>

    <div class="relative" style="height: 400px;">
      <BarChart v-if="chartData.labels.length" :key="chartKey" :chartData="chartData" :options="chartOptions" />
      <p v-else>Chargement des données...</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { getWorkingTimes } from '../services/workingTimeService';
import { Bar } from 'vue-chartjs';
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from 'chart.js';
import { format, subDays, eachDayOfInterval } from 'date-fns';

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);

const BarChart = {
  props: ['chartData', 'options'],
  components: {
    Bar
  },
  template: '<Bar :data="chartData" :options="options" />'
};

const chartData = ref({
  labels: [],
  datasets: [
    {
      label: 'Heures travaillées',
      backgroundColor: '#f87979',
      data: [],
    },
  ],
});

const chartOptions = ref({
  responsive: true,
  maintainAspectRatio: false,
  scales: {
    y: {
      beginAtZero: true,
    }
  }
});

const chartKey = ref(0);

const errorMessage = ref('');
const successMessage = ref('');

function hideMessages() {
  setTimeout(() => {
    errorMessage.value = '';
    successMessage.value = '';
  }, 5000);
}

function getLast7Days() {
  const today = new Date();
  const last7Days = eachDayOfInterval({
    start: subDays(today, 6),
    end: today
  });

  return last7Days.map(date => format(date, 'yyyy-MM-dd'));
}

function groupWorkingTimesByDay(workingTimes) {
  const groupedData = {};

  workingTimes.forEach(wt => {
    const day = wt.start.split('T')[0];
    const start = new Date(wt.start);
    const end = new Date(wt.end);
    const hoursWorked = (end - start) / (1000 * 60 * 60);
    if (groupedData[day]) {
      groupedData[day] += hoursWorked;
    } else {
      groupedData[day] = hoursWorked;
    }
  });

  return groupedData;
}

async function loadChartData() {
  const userId = localStorage.getItem('userId');
  if (!userId) return;

  try {
    const response = await getWorkingTimes(userId);
    const workingTimes = response.data.data;

    const last7Days = getLast7Days();

    const groupedData = groupWorkingTimesByDay(workingTimes);

    const labels = last7Days;
    const data = last7Days.map(day => groupedData[day] || 0);

    chartData.value = {
      labels: [],
      datasets: [
        {
          label: 'Heures travaillées',
          backgroundColor: '#f87979',
          data: []
        }
      ]
    };

    Object.assign(chartData.value, {
      labels: labels,
      datasets: [{
        ...chartData.value.datasets[0],
        data: data
      }]
    });

    chartKey.value++;

    successMessage.value = 'Données du graphique mises à jour avec succès.';
    errorMessage.value = '';
    hideMessages();
  } catch (error) {
    console.error('Erreur lors du chargement des périodes de travail:', error);
    errorMessage.value = 'Une erreur est survenue lors du chargement des données.';
    successMessage.value = '';
    hideMessages();
  }
}

function reloadChart() {
  loadChartData();
  console.log('Le graphique a été rechargé.');
}

onMounted(() => {
  loadChartData();
});
</script>

<style scoped>
</style>
