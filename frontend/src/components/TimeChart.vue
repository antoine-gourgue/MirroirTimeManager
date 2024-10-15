<template>
  <div>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script>
import {Chart, registerables} from 'chart.js';

Chart.register(...registerables);

const dates = ["2024-10-14"]
const workingHours = [[Date.now(), Date.now() + 3], [Date.now() + 4, Date.now() + 6]]

const restHours = []
for (let i = 0; i < workingHours.length - 1; ++i) {
  restHours.push([workingHours[i][1], workingHours[i + 1][0]])
}

const plotedHours = []
for (let i = 0; i < restHours.length; ++i) {
  plotedHours.push({
    label: "Working hours",
    data: [workingHours[i][1] - workingHours[i][0]],
    backgroundColor: 'blue',
    borderColor: 'blue',
    borderWidth: 1,
  })
  plotedHours.push({
    label: "Rest hours",
    data: [restHours[i][1] - restHours[i][0]],
    backgroundColor: 'grey',
    borderColor: 'grey',
    borderWidth: 1,
  },)
}
plotedHours.push({
  data: [workingHours[workingHours.length - 1][1] - workingHours[workingHours.length - 1][0]],
  backgroundColor: 'blue',
  borderColor: 'blue',
  borderWidth: 1,
},)

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
          labels: dates,
          datasets: plotedHours,
        },
        options: {
          responsive: true,
          indexAxis: "y",
          scales: {
            x: {
              stacked: true,
            },
            y: {
              stacked: true,
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
