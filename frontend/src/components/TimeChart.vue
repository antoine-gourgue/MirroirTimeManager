<template>
  <div>
    <canvas ref="barChart"></canvas>
  </div>
</template>

<script>
import { ref, onMounted } from 'vue';
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

export default {
  name: 'GroupedBarChart',
  setup() {
    const barChart = ref(null);

    const labels = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    const scheduleData = [8, 6, 7, 5, 9]; // Example scheduled hours
    const workingHoursData = [7, 5, 6, 4, 8]; // Example actual working hours

    onMounted(() => {
      const ctx = barChart.value.getContext('2d');

      const myBarChart = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: labels,
          datasets: [
            {
              label: 'Scheduled Hours',
              data: scheduleData,
              backgroundColor: 'rgba(75, 192, 192, 0.5)',
              borderColor: 'rgba(75, 192, 192, 1)',
              borderWidth: 1,
              barPercentage: 0.5, // Adjust the width of the bars
            },
            {
              label: 'Working Hours',
              data: workingHoursData,
              backgroundColor: 'rgba(255, 99, 132, 0.5)',
              borderColor: 'rgba(255, 99, 132, 1)',
              borderWidth: 1,
              barPercentage: 0.5, // Adjust the width of the bars
            },
          ],
        },
        options: {
          responsive: true,
          scales: {
            x: {
              stacked: false, // Set to false to display bars side by side
            },
            y: {
              beginAtZero: true,
              title: {
                display: true,
                text: 'Hours',
              },
            },
          },
          plugins: {
            legend: {
              position: 'top',
            },
          },
        },
      });
    });

    return {
      barChart,
    };
  },
};
</script>

<style scoped>
canvas {
  max-width: 600px;
  max-height: 400px;
}
</style>
