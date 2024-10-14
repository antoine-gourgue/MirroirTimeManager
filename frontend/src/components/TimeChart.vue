<template>
  <div>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script>
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

export default {
  name: 'TimeChart',
  mounted() {
    this.renderChart();
  },
  methods: {
    renderChart() {
      const ctx = this.$refs.myChart.getContext('2d');
      new Chart(ctx, {
        type: 'bar',
        data: {
          labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
          datasets: [
            {
              label: 'Dataset 1',
              data: [65, 59, 80, 81, 56, 55, 40],
              backgroundColor: 'rgba(255, 99, 132, 0.2)',
              borderColor: 'rgba(255, 99, 132, 1)',
              borderWidth: 1,
            },
            {
              label: 'Dataset 2',
              data: [28, 48, 40, 19, 86, 27, 90],
              backgroundColor: 'rgba(54, 162, 235, 0.2)',
              borderColor: 'rgba(54, 162, 235, 1)',
              borderWidth: 1,
            },
            {
              label: 'Dataset 3',
              data: [18, 30, 60, 45, 30, 70, 50],
              backgroundColor: 'rgba(75, 192, 192, 0.2)',
              borderColor: 'rgba(75, 192, 192, 1)',
              borderWidth: 1,
            },
          ],
        },
        options: {
          responsive: true,
          indexAxis: "y",
          scales: {
            x: {
              stacked: true, // Enable stacking on the x-axis
            },
            y: {
              stacked: true, // Enable stacking on the y-axis
            },
          },
        },
      });
    },
  },
};
</script>

<style scoped>
canvas {
  max-width: 600px;
}
</style>
