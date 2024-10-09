<template>
  <div class="chart-container">
  </div>
</template>

<script>
import Chart from 'chart.js/auto';

const fetchWorkingDurations = async () => {
  const workingDurations = await fetch(`http://localhost:4000/api/workingtime/${1}/`)
    .then((res) => res.json())
    .then((json) => json.data)
    .then((elements) => {
      return elements.map((element) => {
        const start = new Date(element.start)
        const end = new Date(element.end)
        const date = element.start.split('T')[0]
        return { date: date, duration: (end - start) / (1000 * 60 * 60) } // Convert ms to hours
      })
    })

  return workingDurations
}

const workingDurations = await fetchWorkingDurations()
console.log(workingDurations)

new Chart(
  document.getElementById('.chart-container'),
  {
    type: 'bar',
    options: {
      animation: false,
      plugins: {
        legend: {
          display: false
        },
        tooltip: {
          enabled: false
        }
      }
    },
    data: {
      labels: workingDurations.map(row => row.date),
      datasets: [
        {
          label: 'Acquisitions by year',
          data: workingDurations.map(row => row.duration)
        }
      ]
    }
  }
);


</script>

<style>
.chart-container {
  width: 600px;
  height: 400px;
}
</style>
