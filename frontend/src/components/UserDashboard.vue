<template>
  <SideBar />
  <div class="main-container">
    <AppBanner @updateWorkingTimes="fetchUserWorkingTimes" />

    <div class="graph-container">
      <div class="graph small-graph">
        <h2 class="roboto-bold">Aujourd'hui</h2>
        <KnobGraphForUserCard :percentageOfWorkedHours="todayWorkPercentage" class="big-knob" />
      </div>

      <div class="graph small-graph">
        <h2 class="roboto-bold">Détails</h2>
        <p>Heures obligatoires : 8:30 - 12:30 / 14:00 - 17:00</p>

        <p>Heures supplémentaires payées disponibles : {{ formatTime(paidOvertime) }}</p>
        <div class="progress-outside">
          <div class="progress-inside paid-overtime"
               :style="{ width: `${(paidOvertime / 5) * 100}%` }"
               :data-tooltip="`Heures payées : ${formatTime(paidOvertime)}`">
          </div>
        </div>

        <p>Heures supplémentaires non payées : {{ formatTime(unpaidOvertime) }} </p>
        <div class="progress-outside">
          <div class="progress-inside unpaid-overtime"
               :style="{ width: `${(unpaidOvertime / 35) * 100}%` }"
               :data-tooltip="`Heures non payées : ${formatTime(unpaidOvertime)}`">
          </div>
        </div>

        <p>Postes de nuit cette semaine : {{ formatTime(nightShifts) }} </p>
        <div class="progress-outside">
          <div class="progress-inside night-shifts"
               :style="{ width: `${(nightShifts / 35) * 100}%` }"
               :data-tooltip="`Heures de nuit : ${formatTime(nightShifts)}`">
          </div>
        </div>
      </div>
    </div>

    <div class="graph big-graph">
      <div class="graph-header">
        <h2 class="roboto-bold">Les {{ selectedDays }} derniers jours</h2>
        <div class="filter-buttons">
          <button @click="selectedDays = 7; applyFilter()">7 jours</button>
          <button @click="selectedDays = 15; applyFilter()">15 jours</button>
          <button @click="selectedDays = 30; applyFilter()">30 jours</button>
        </div>
      </div>
      <TimeChart :working-hours="filteredWorkingHours" :selected-days="selectedDays" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import TimeChart from './TimeChart.vue';
import KnobGraphForUserCard from './KnobGraphForUserCard.vue';
import { getWorkingTimeByeUserId } from '@/services/api';

let paidOvertime = ref(0);
let unpaidOvertime = ref(0);
let nightShifts = ref(0);
let todayWorkPercentage = ref(0);
let userWorkingHours = ref([]);
let filteredWorkingHours = ref([]);
let selectedDays = ref(7);

async function fetchUserWorkingTimes() {
  userWorkingHours.value = await getWorkingTimeByeUserId(sessionStorage.user_id);
  calculateTodayWorkPercentage();
  applyFilter();
  calculateOvertimeAndNightShifts();
}

function calculateTodayWorkPercentage() {
  const now = new Date();
  const todayStart = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0);
  const todayEnd = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 23, 59, 59);

  let totalWorkedHoursToday = 0;

  userWorkingHours.value.forEach((item) => {
    const startTime = new Date(item.start_time);
    const endTime = new Date(item.end_time);

    if (startTime >= todayStart && endTime <= todayEnd && item.type === "work") {
      const hoursWorked = (endTime - startTime) / (1000 * 60 * 60);
      totalWorkedHoursToday += hoursWorked;
    }
  });

  todayWorkPercentage.value = Math.min((totalWorkedHoursToday / 7) * 100, 100);
}

function applyFilter() {
  const now = new Date();
  filteredWorkingHours.value = userWorkingHours.value.filter((item) => {
    const startTime = new Date(item.start_time);
    const timeDifference = (now - startTime) / (1000 * 60 * 60 * 24);
    return timeDifference <= selectedDays.value;
  });
}

function calculateOvertimeAndNightShifts() {
  let workedHoursLast7Days = 0;
  let nightShiftHours = 0;
  const now = new Date();

  filteredWorkingHours.value.forEach((item) => {
    const startTime = new Date(item.start_time);
    const endTime = new Date(item.end_time);
    const timeDifferenceInDays = (now - startTime) / (1000 * 60 * 60 * 24);

    if (timeDifferenceInDays <= 7 && item.type === "work") {
      const hoursWorked = (endTime - startTime) / (1000 * 60 * 60);
      workedHoursLast7Days += hoursWorked;
      nightShiftHours += calculateNightShiftHours(startTime, endTime);
    }
  });

  if (workedHoursLast7Days > 35) {
    paidOvertime.value = Math.min(workedHoursLast7Days - 35, 5);
    unpaidOvertime.value = Math.max(workedHoursLast7Days - 40, 0);
  } else {
    paidOvertime.value = 0;
    unpaidOvertime.value = 0;
  }

  nightShifts.value = nightShiftHours;
}

function calculateNightShiftHours(startTime, endTime) {
  const nightStart = new Date(startTime);
  nightStart.setHours(23, 0, 0, 0);

  const nightEnd = new Date(startTime);
  nightEnd.setDate(nightEnd.getDate() + 1);
  nightEnd.setHours(6, 0, 0, 0);

  let totalNightHours = 0;

  if (startTime < nightEnd && endTime > nightStart) {
    const startNight = startTime < nightStart ? nightStart : startTime;
    const endNight = endTime > nightEnd ? nightEnd : endTime;
    totalNightHours = (endNight - startNight) / (1000 * 60 * 60);
  }

  return totalNightHours;
}

function formatTime(hours) {
  const fullHours = Math.floor(hours);
  const minutes = Math.round((hours - fullHours) * 60);
  return `${fullHours}h ${minutes}min`;
}

onMounted(fetchUserWorkingTimes);
</script>

<style scoped>
.big-knob {
  transform: scale(200%);
  position: relative;
  top: -55px;
}

.main-container {
  width: 100%;
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: var(--light);
}

.graph-container {
  width: 95%;
  height: 40%;
  display: flex;
  justify-content: space-between;
  margin: 12px 0;
}

.graph {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: space-between;
  box-shadow: 0px 4px 9px 3px rgba(2, 2, 0, 0.4);
  border-radius: 10px;
  background-color: white;
  padding: 15px 25px;
  min-width: 345px;
  min-height: 315px;
}

.big-graph {
  width: 95%;
  height: 45%;
  margin-bottom: 15px;
}

.small-graph {
  width: 48%;
  height: 100%;
}

.small-graph h2,
.big-graph h2 {
  font-size: 36px;
}

.progress-outside {
  height: 25px;
  width: 300px;
  background-color: #b6b5b560;
  border-radius: 15px;
  position: relative;
  max-width: 300px;
}

.progress-inside {
  height: 100%;
  border-radius: 15px;
  position: relative;
}

.progress-inside::after {
  content: attr(data-tooltip);
  visibility: hidden;
  opacity: 0;
  background-color: rgba(0, 0, 0, 0.75);
  color: #fff;
  text-align: center;
  padding: 5px;
  border-radius: 5px;
  position: absolute;
  top: -30px;
  left: 50%;
  transform: translateX(-50%);
  white-space: nowrap;
  font-size: 12px;
  transition: opacity 0.2s;
}

.progress-inside:hover::after {
  visibility: visible;
  opacity: 1;
}

.paid-overtime {
  background-color: #f2bc0f;
}

.unpaid-overtime {
  background-color: #e80c13;
}

.night-shifts {
  background-color: #3498db;
}

.small-graph p {
  align-self: flex-start;
}

.graph-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.filter-buttons {
  display: flex;
  gap: 10px;
}

.filter-buttons button {
  padding: 8px 16px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

@media (max-width: 940px) {
  .main-container {
    height: auto;
    min-height: 100%;
  }

  .graph-container {
    flex-direction: column;
    align-items: center;
    width: 100%;
    height: auto;
  }

  .graph {
    margin-bottom: 15px;
    width: 100%;
  }
}
</style>
