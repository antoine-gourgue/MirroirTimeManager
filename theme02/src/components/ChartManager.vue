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
import { ref, onMounted } from 'vue';
import { Bar } from 'vue-chartjs';
import { BarElement, CategoryScale, Chart as ChartJS, Legend, LinearScale, Title, Tooltip } from 'chart.js';

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale);

export default {
  props: ['us' +
  'erId'],
  name: 'BarChart',
  components: { Bar },
  setup(props) {
    const chartData = ref({
      labels: [],
      datasets: [{
        label: 'My working hours',
        data: [],
        backgroundColor: 'rgba(75, 192, 192, 0.6)',
        maxBarThickness: 15
      }]
    });

    const chartOptions = ref({
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

    });

    const fetchWorkingDurations = async () => {
      const workingDurations = await fetch(`http://localhost:4000/api/workingtime/${props.userId}/`)
        .then((res) => res.json())
        .then((json) => json.data)
        .then((elements) => {
          return elements.map((element) => {
            const start = new Date(element.start);
            const end = new Date(element.end);
            const date = element.start.split('T')[0];
            return {date: date, duration: (end - start) / (1000 * 60 * 60) }; // Convert ms to hours
          });
        });

      chartData.value.labels = workingDurations.map(item => item.date);
      console.log(workingDurations.map(item => item.date))
      chartData.value.datasets[0].data = workingDurations.map(item => item.duration);
      console.log(chartData)
    };

    onMounted(async () => {
      await fetchWorkingDurations();
    });



    return {
      chartData,
      chartOptions
    };
  }
}
</script>

<style>
.chart-container {
  width: 600px;
  height: 400px;
}
</style>
