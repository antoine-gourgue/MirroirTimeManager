<template>
  <div class="chart-container">
    <Bar
      id="my-chart-id"
      :options="chartOptions"
      :data="chartData"
    />
  </div>
</template>

<script>
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
  name: 'BarChart',
  components: { Bar },
  data() {
    return {
      chartData: {
        labels: ['January', 'February', 'March'],
        datasets: [{
          label: 'My working hours',
          data: [7, 6, 8],
          backgroundColor: 'rgba(75, 192, 192, 0.6)',
          maxBarThickness: 15
        }]
      },
      chartOptions: {
        responsive: true,
        indexAxis: 'y',
        scales: {
          x: {
            title: {
              display: true,
              text: 'Working hours'
            },
            beginAtZero: true
          },
          y: {
            title: {
              display: true,
              text: 'Date'
            }
          }
        }
      }
    }
  }
}
</script>

<style>
.chart-container {
  width: 600px;
  height: 400px;
}
</style>
