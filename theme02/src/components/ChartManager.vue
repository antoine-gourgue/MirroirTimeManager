<template>
  <div class="bg-white p-6 rounded-lg shadow-md mb-6">
    <h2 class="text-xl font-semibold mb-4">Gestion des graphiques</h2>

    <!-- Bouton pour recharger les données -->
    <button @click="reloadChart" class="mb-4 bg-blue-500 text-white py-2 px-4 rounded hover:bg-blue-600">
      Recharger le graphique
    </button>

    <div class="relative" style="height: 400px;">
      <BarChart v-if="chartData.labels.length" :key="chartKey" :chartData="chartData" :options="chartOptions" />
      <p v-else>Chargement des données...</p>
    </div>
  </div>
</template>

<script setup>
import {ref, onMounted} from 'vue';
import {getWorkingTimes} from '../services/workingTimeService';
import {Bar} from 'vue-chartjs';
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale,
} from 'chart.js';
import {format, subDays, eachDayOfInterval} from 'date-fns';

// Enregistrer les composants requis pour Chart.js
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);

// Composant BarChart
const BarChart = {
  props: ['chartData', 'options'],
  components: {
    Bar
  },
  template: '<Bar :data="chartData" :options="options" />'
};

// Les données et options pour le graphique
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

// Clé dynamique pour forcer la mise à jour du composant
const chartKey = ref(0);

// Fonction pour obtenir les 7 derniers jours avec un format spécifique
function getLast7Days() {
  const today = new Date();
  const last7Days = eachDayOfInterval({
    start: subDays(today, 6),  // Il inclut le jour actuel, donc on fait -6 pour avoir 7 jours
    end: today
  });

  return last7Days.map(date => format(date, 'yyyy-MM-dd'));
}

// Fonction pour regrouper les heures par jour
function groupWorkingTimesByDay(workingTimes) {
  const groupedData = {};

  workingTimes.forEach(wt => {
    const day = wt.start.split('T')[0]; // Extraire la date (format yyyy-MM-dd)
    const start = new Date(wt.start);
    const end = new Date(wt.end);
    const hoursWorked = (end - start) / (1000 * 60 * 60); // Calculer les heures travaillées

    if (groupedData[day]) {
      groupedData[day] += hoursWorked;
    } else {
      groupedData[day] = hoursWorked;
    }
  });

  return groupedData;
}

// Récupération des données depuis l'API et mise à jour du graphique
async function loadChartData() {
  const userId = localStorage.getItem('userId');
  if (!userId) return;

  try {
    const response = await getWorkingTimes(userId);
    const workingTimes = response.data.data;

    // Obtenir les 7 derniers jours
    const last7Days = getLast7Days();

    // Grouper les périodes de travail par jour
    const groupedData = groupWorkingTimesByDay(workingTimes);

    // Préparer les données pour le graphique
    const labels = last7Days;
    const data = last7Days.map(day => groupedData[day] || 0); // Si aucun travail ce jour, mettre 0

    // Réinitialisation des données avant mise à jour
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

    // Utiliser Object.assign pour mettre à jour le contenu de chartData
    Object.assign(chartData.value, {
      labels: labels,
      datasets: [{
        ...chartData.value.datasets[0],
        data: data
      }]
    });

    // Forcer le re-rendu du graphique
    chartKey.value++;

    console.log('Données du graphique mises à jour:', chartData.value);
  } catch (error) {
    console.error('Erreur lors du chargement des périodes de travail:', error);
  }
}

// Fonction pour recharger le graphique sans recharger la page
function reloadChart() {
  loadChartData();  // Recharge les données
  console.log('Le graphique a été rechargé.');
}

// Charger les données au montage du composant
onMounted(() => {
  loadChartData();
});
</script>

<style scoped>
</style>
