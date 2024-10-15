<template>
  <div>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script>
import {Chart, registerables} from 'chart.js';

Chart.register(...registerables);

const workingHours = [
  [new Date(2024, 10, 14, 8, 0, 0, 0),
    new Date(2024, 10, 14, 12, 0, 0, 0)],
  [new Date(2024, 10, 14, 14, 0, 0, 0),
    new Date(2024, 10, 14, 18, 0, 0, 0)],
  [new Date(2024, 10, 15, 8, 0, 0, 0),
    new Date(2024, 10, 15, 12, 0, 0, 0)],
  [new Date(2024, 10, 15, 14, 0, 0, 0),
    new Date(2024, 10, 15, 18, 0, 0, 0)],
  [new Date(2024, 10, 16, 14, 0, 0, 0), // working time spread on two days
    new Date(2024, 10, 17, 18, 0, 0, 0)]
].sort((a, b) => a[0] - b[0]) // ascending start date sort
const workingHoursByDay = new Map()
for (let i = 0; i < workingHours.length; ++i) {
  const workingTime = workingHours[i]
  const startDateStr = workingTime[0].toISOString().split('T')[0]
  const endDateStr = workingTime[1].toISOString().split('T')[0]
  if (!workingHoursByDay.has(startDateStr)) {
    workingHoursByDay.set(startDateStr, [])
  }
  if (!workingHoursByDay.has(endDateStr)) {
    workingHoursByDay.set(endDateStr, [])
  }
  if (new Date(startDateStr).getTime() !== new Date(endDateStr).getTime()) {
    let startTimeFirstDay = new Date(startDateStr)
    startTimeFirstDay.setHours(23)
    startTimeFirstDay.setMinutes(59)
    startTimeFirstDay.setSeconds(59)

    workingHoursByDay.get(startDateStr).push([workingTime[0], startTimeFirstDay])
    workingHoursByDay.get(endDateStr).push([new Date(endDateStr), workingTime[1]])
  } else {
    workingHoursByDay.get(startDateStr).push(workingTime)
  }
}

for (const [date, workingHours] of workingHoursByDay) {
  const dayStart = new Date(date)
  const dayEnd = new Date(date)
  dayEnd.setHours(23)
  dayEnd.setMinutes(59)
  dayEnd.setSeconds(59)

  let newWorkingHours = [[dayStart, workingHours[0][0]]]
  for (let i = 0; i < workingHours.length - 1; ++i) {
    newWorkingHours.push(workingHours[i])
    newWorkingHours.push([workingHours[i][1], workingHours[i + 1][0]])
  }
  newWorkingHours.push(workingHours[workingHours.length - 1])
  newWorkingHours.push([workingHours[workingHours.length - 1][1], dayEnd])
  workingHoursByDay.set(date, newWorkingHours)
}
let durations = []
for (let i = 0; i < 10; ++i) {
  let days = Array.from(workingHoursByDay.keys())
  durations.push(days.map(date => {
    console.log(i >= workingHoursByDay.get(date).length)
    console.log(i)
    if (i >= workingHoursByDay.get(date).length) {
      return 0
    } else {
      return (workingHoursByDay.get(date)[i][1] - workingHoursByDay.get(date)[i][0]) / 1000 // convert from ms to s
    }
  }))
}

const plots = []
for (let i = 0; i < workingHours.length / 2; ++i) {
  plots.push({
    data: durations[2 * i],
    backgroundColor: 'grey',
    borderColor: 'grey',
    borderWidth: 1,
  })
  plots.push({
    data: durations[2 * i + 1],
    backgroundColor: 'blue',
    borderColor: 'blue',
    borderWidth: 1,
  },)
}
plots.push({
  data: durations[durations.length - 1],
  backgroundColor: 'grey',
  borderColor: 'grey',
  borderWidth: 1,
})

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
          labels: Array.from(workingHoursByDay.keys()),
          datasets: plots,
        },
        options: {
          responsive: true,
          plugins: {
            legend: {
              display: false
            }
          },
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
