<template>
  <div>
    <p>Mandatory hours: {{
        `${schedule[0].getHours().toString().padStart(2, '0')}:${schedule[0].getMinutes().toString().padStart(2, '0')} - ${schedule[1].getHours().toString().padStart(2, '0')}:${schedule[1].getMinutes().toString().padStart(2, '0')}`
      }}</p>
    <p>Remaining paid overtime hours: {{ 5 - totalOvertime + "h" }}</p>
    <canvas ref="myChart"></canvas>
  </div>
</template>

<script setup>
import {Chart, registerables} from 'chart.js';
import {onMounted, ref} from 'vue';

Chart.register(...registerables);

const props = defineProps({
  workingHours: {
    type: Array,
    required: true
  },
})

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

function categorizeByDate(workingHours) {
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
  return workingHoursByDay
}

function computeAvgWorkingTimeByDay(workingHoursByDay) {
  const avgTimesByDay = new Map()
  for (const [date, workingHours] of workingHoursByDay) {
    const usersNumber = new Set(props.workingHours.map(workingHour => workingHour.user_id)).size
    avgTimesByDay.set(
        date,
        workingHours.reduce(
            (acc, workingHour) => acc + (workingHour[1].getTime() - workingHour[0].getTime()) / 1000 / 3600, 0) / usersNumber
    ) // get mean working time in hours
  }
  return avgTimesByDay
}

const workingHours = subtractBreaksFromWork(
    props.workingHours
        .filter(e => e.type === "work")
        .map(e => [new Date(e.start_time), new Date(e.end_time)]),
    props.workingHours
        .filter(e => e.type === "break")
        .map(e => [new Date(e.start_time), new Date(e.end_time)]))
const workingHoursByDay = categorizeByDate(workingHours)
const avgWorkingTimePerDay = computeAvgWorkingTimeByDay(workingHoursByDay)
console.log(avgWorkingTimePerDay)

const myChart = ref(null)
const chartData = {
  labels: ['Average working time'],
  datasets: [
    {
      label: [Array.from(avgWorkingTimePerDay.keys())],
      data: [Array.from(avgWorkingTimePerDay.values())],
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
      max: 5,
      title: {
        display: true,
        text: 'Overtime done',
      },
      grid: {
        display: false,
        drawBorder: false
      },
      ticks: {
        display: true
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
canvas {
  position: relative;
  width: 100%;
  height: 100px;
}
</style>
