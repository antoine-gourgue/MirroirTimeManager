<script setup>
import { ref, onMounted } from 'vue';
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import TimeChart from './TimeChart.vue';
import KnobGraphForUserCard from './KnobGraphForUserCard.vue';
import { getWorkingTimeByeUserId } from '@/services/api';

let paidOvertime = 80;
let nightShifts = 20;
let paidOvertimeRatio = `${paidOvertime}%`;
let nightShiftsRatio = `${nightShifts}%`;

let userWorkingHours = ref([]);
let filteredWorkingHours = ref([]);
let selectedDays = ref(7); // Période par défaut : 7 jours

// Fonction pour récupérer les working times
async function fetchUserWorkingTimes() {
  userWorkingHours.value = await getWorkingTimeByeUserId(sessionStorage.user_id);
  applyFilter();
}

// Filtrer les données pour la période choisie
function applyFilter() {
  const now = new Date();
  filteredWorkingHours.value = userWorkingHours.value.filter((item) => {
    const startTime = new Date(item.start_time);
    const timeDifference = (now - startTime) / (1000 * 60 * 60 * 24); // Différence en jours
    return timeDifference <= selectedDays.value;
  });
}

// Charger les données lors du montage
onMounted(fetchUserWorkingTimes);
</script>

<template>
  <SideBar />
  <div class="main-container">
    <!-- Écoute de l'événement updateWorkingTimes -->
    <AppBanner @updateWorkingTimes="fetchUserWorkingTimes" />

    <div class="graph-container">
      <div class="graph small-graph">
        <h2 class="roboto-bold">Aujourd'hui</h2>
        <KnobGraphForUserCard :percentageOfWorkedHours="90" class="big-knob" />
      </div>
      <div class="graph small-graph">
        <h2 class="roboto-bold">Détails</h2>
        <p>Heures obligatoires : 8:30 - 12:30 / 14:00 - 17:00</p>
        <p>Heures supplémentaires payées disponibles : 4 heures</p>
        <div class="progress-outside">
          <div class="progress-inside paid-overtime"></div>
        </div>
        <p>Heures supplémentaires non payées : 0 heures</p>
        <p>Postes de nuit cette semaine : 1</p>
        <div class="progress-outside">
          <div class="progress-inside night-shifts"></div>
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


<style>
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

/* Styles pour le header des filtres */
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

.progress-outside {
  height: 25px;
  width: 300px;
  background-color: #b6b5b560;
  border-radius: 15px;
}

.progress-inside {
  height: 100%;
  border-radius: 15px;
}

.paid-overtime {
  background-color: #f2bc0f;
  width: v-bind('paidOvertimeRatio');
}

.night-shifts {
  background-color: #e80c13;
  width: v-bind('nightShiftsRatio');
}

.small-graph p {
  align-self: flex-start;
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
