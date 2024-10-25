<template>
  <div>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script setup>
import { Chart, registerables } from 'chart.js';
import { ref, onMounted, onBeforeUnmount, watch } from 'vue';

Chart.register(...registerables);

const props = defineProps({
  workingHours: {
    type: Array,
    required: true
  },
  selectedDays: {
    type: Number,
    required: true
  }
});

let chartInstance = null;
const myChart = ref(null);

function processWorkingTimes(workingHours) {
  const dailyData = {};

  const now = new Date();
  const startDate = new Date(now);
  startDate.setDate(now.getDate() - props.selectedDays);

  workingHours.forEach(entry => {
    const entryDate = new Date(entry.start_time);
    const dateStr = entryDate.toISOString().split('T')[0];
    const start = new Date(entry.start_time);
    const end = new Date(entry.end_time);

    const hoursWorked = (end - start) / (1000 * 3600);

    if (entryDate < startDate || entryDate > now) return;

    if (!dailyData[dateStr]) {
      dailyData[dateStr] = { work: 0, break: 0 };
    }

    if (entry.type === 'work') {
      dailyData[dateStr].work += hoursWorked;
    } else if (entry.type === 'dayOff') {
      dailyData[dateStr].break += hoursWorked;
    }
  });

  return dailyData;
}

function generateChartData(dailyData) {
  const labels = Object.keys(dailyData).sort();
  const workHours = [];
  const breakHours = [];

  labels.forEach(date => {
    workHours.push(dailyData[date].work);
    breakHours.push(dailyData[date].break);
  });

  return {
    labels,
    datasets: [
      {
        label: 'Work Hours',
        data: workHours,
        backgroundColor: 'rgba(75, 192, 192, 0.6)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1
      },
      {
        label: 'Break Hours',
        data: breakHours,
        backgroundColor: 'rgba(255, 159, 64, 0.6)',
        borderColor: 'rgba(255, 159, 64, 1)',
        borderWidth: 1
      }
    ]
  };
}

function renderChart() {
  const dailyData = processWorkingTimes(props.workingHours);
  const chartData = generateChartData(dailyData);

  if (chartInstance) {
    chartInstance.destroy();
  }

  const ctx = myChart.value.getContext('2d');
  chartInstance = new Chart(ctx, {
    type: 'bar',
    data: chartData,
    options: {
      responsive: true,
      scales: {
        x: {stacked: true},
        y: {
          stacked: true,
          title: {
            display: true,
            text: 'Hours'
          },
          ticks: {
            callback: value => value + 'h'
          }
        }
      }
    }
  });
}

// Met à jour le graphique si les données changent
watch([() => props.workingHours, () => props.selectedDays], renderChart);

onBeforeUnmount(() => {
  if (chartInstance) {
    chartInstance.destroy();
  }
});

onMounted(renderChart);
</script>

<style scoped>
canvas {
  width: 100%;
  height: 100%;
  min-width: 600px;
  min-height: 300px;
}
</style>
