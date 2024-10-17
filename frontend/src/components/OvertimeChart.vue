<template>
  <div>
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
  schedule: {
    type: Array,
    required: true
  }
})

function separateDateRanges(workingHours, schedule) {
  const insideSchedule = [];
  const outsideSchedule = [];

  const scheduleStart = new Date(schedule[0])
  const scheduleEnd = new Date(schedule[1])

  const scheduleStartSeconds = scheduleStart.getHours() + scheduleStart.getMinutes() + scheduleStart.getSeconds()
  const scheduleEndSeconds = scheduleEnd.getHours() + scheduleEnd.getMinutes() + scheduleEnd.getSeconds()

  workingHours.forEach(range => {
    const rangeStart = new Date(range[0]);
    const rangeEnd = new Date(range[1]);

    const rangeStartSeconds = rangeStart.getHours() + rangeStart.getMinutes() + rangeStart.getSeconds()
    const rangeEndSeconds = rangeEnd.getHours() + rangeEnd.getMinutes() + rangeEnd.getSeconds()

    // Case 1: Range is completely outside the schedule
    if (rangeEndSeconds < scheduleStartSeconds || rangeStartSeconds > scheduleEndSeconds) {
      outsideSchedule.push(range);
    }
    // Case 2: Range is completely inside the schedule
    else if (rangeStartSeconds >= scheduleStartSeconds && rangeEndSeconds <= scheduleEndSeconds) {
      insideSchedule.push(range);
    }
    // Case 3: Range overlaps with the schedule
    else {
      // If the start of the range is before the schedule starts
      if (rangeStartSeconds < scheduleStartSeconds) {
        outsideSchedule.push([rangeStart, scheduleStart]);
      }
      // If the end of the range is after the schedule ends
      if (rangeEndSeconds > scheduleEndSeconds) {
        outsideSchedule.push([scheduleEnd, rangeEnd]);
      }
      // The part that is inside the schedule
      insideSchedule.push([
        rangeStartSeconds > scheduleStartSeconds ? rangeStart : scheduleStart,
        rangeEndSeconds < scheduleEndSeconds ? rangeEnd : scheduleEnd
      ])
    }
  });

  return {insideSchedule, outsideSchedule};
}

const result = separateDateRanges(props.workingHours, props.schedule);


const myChart = ref(null)
const chartData = {
  labels: ['Daytime', 'Nighttime'],
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
        display: true
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
