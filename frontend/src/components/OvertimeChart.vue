<template>
  <div>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script setup>
import { Chart, registerables } from 'chart.js';
import { onMounted, ref } from 'vue';

Chart.register(...registerables);

const props = defineProps({
  daytimeDone: {
    type: Number,
    required: true
  },
  nighttimeDone: {
    type: Number,
    required: true
  }
})

const myChart = ref(null)
const chartData = {
  labels: ['Daytime overtime done', 'Nighttime overtime done'],
  datasets: [
    {
      label: ["Daytime", "Nighttime"],
      data: [props.daytimeDone, props.nighttimeDone],
      backgroundColor: 'blue',
      borderColor: 'blue',
      borderWidth: 1,
      borderRadius: 10,
      barThickness: 20,
    },
  ],
}
const chartOptions = {
  responsive: true,
  plugins: {
    legend: {
      display: false
    }
  },
  indexAxis: "y",
  scales: {
    x: {
      min: 0,
      max: 100,
      title: {
        display: false,
        text: 'Overtime done',
      },
      grid: {
        display: false,
        drawBorder: false
      },
      ticks: {
        display: false
      }
    },
    y: {
      beginAtZero: true,
      ticks: {
        display: false
      },
      grid: {
        display: false,
        drawBorder: false
      }
    },
  },
}

onMounted(() => {
  const ctx = myChart.value.getContext('2d');
  new Chart(ctx, {
    type: 'bar',
    data: chartData,
    options: chartOptions,
  });
});
</script>

<style scoped>
Bar {
  position: relative;
  width: 100%;
  height: 50px;
}
</style>
