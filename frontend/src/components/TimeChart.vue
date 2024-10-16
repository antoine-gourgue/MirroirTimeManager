<template>
  <div>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script>
import {Chart, registerables} from 'chart.js';

Chart.register(...registerables);

// const props = defineProps({
//   workingHours: {
//     type: Array,
//     required: true
//   }
// })

const workingHoursRequest = [
  {
    "id": 1,
    "type": "work",
    "start_time": "2024-10-14T09:00:00",
    "user_id": 1,
    "end_time": "2024-10-14T17:00:00"
  },
  {
    "id": 2,
    "type": "break",
    "start_time": "2024-10-14T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-14T12:30:00"
  }
]

function subtractBreaksFromWork(workingHours, restHours) {
  const adjustedWorkingHours = []
  for (const [workStart, workEnd] of workingHours) {
    let currentStart = workStart
    let currentEnd = workEnd

    for (const [restStart, restEnd] of restHours) {
      if (restEnd <= currentStart || restStart >= currentEnd) {
        continue
      }
      if (restStart > currentStart) {
        adjustedWorkingHours.push([currentStart, restStart])
      }
      currentStart = new Date(Math.max(currentStart, restEnd))
    }
    if (currentStart < currentEnd) {
      adjustedWorkingHours.push([currentStart, currentEnd])
    }
  }

  return adjustedWorkingHours;
}

const workingHours = subtractBreaksFromWork(
    workingHoursRequest
        .filter(e => e.type === "work")
        .map(e => [new Date(e.start_time), new Date(e.end_time)]),
    workingHoursRequest
        .filter(e => e.type === "break")
        .map(e => [new Date(e.start_time), new Date(e.end_time)]))
    .sort((starTime1, startTime2) => starTime1[0] - startTime2[0]) // ascending start date sort
console.log("workingHours")
console.log(workingHours)
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
console.log("workingHoursByDay")
console.log(Array.from(workingHoursByDay.values()))
// add leading and trailing time span to match a [0h:24h] period
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
console.log("workingHoursByDay")
console.log(Array.from(workingHoursByDay.values()))
let durations = []
for (let i = 0; i < 10; ++i) {
  let days = Array.from(workingHoursByDay.keys())
  durations.push(days.map(date => {
    if (i >= workingHoursByDay.get(date).length) {
      return 0
    } else {
      return (workingHoursByDay.get(date)[i][1] - workingHoursByDay.get(date)[i][0]) / 1000 / 3600 // convert from ms to h
    }
  }))
}
console.log("durations")
console.log(durations)
const plots = []
for (let i = 0; i < workingHours.length / 2 + 2; ++i) {
  console.log("i : " + i)
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
  console.log(Object.assign({}, plots))
}
plots.push({
  data: durations[durations.length - 1],
  backgroundColor: 'grey',
  borderColor: 'grey',
  borderWidth: 1,
})
console.log("plots")
console.log(plots)
export default {
  props: ['workingTimes'],
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
