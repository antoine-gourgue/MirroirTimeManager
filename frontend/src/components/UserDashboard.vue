<script setup>

import { getAllUsers, getUserById } from '@/services/api';
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import { store } from '@/services/store';
import TimeChart from './TimeChart.vue';
import { ref } from 'vue';

let paidOvertime = 80
let nightShifts = 20

let props =  ref(
  [
  {
    "id": 1,
    "type": "work",
    "start_time": "2024-10-01T09:00:00",
    "user_id": 1,
    "end_time": "2024-10-01T17:00:00"
  },
  {
    "id": 2,
    "type": "break",
    "start_time": "2024-10-01T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-01T12:30:00"
  },
  {
    "id": 3,
    "type": "work",
    "start_time": "2024-10-03T09:00:00",
    "user_id": 1,
    "end_time": "2024-10-03T17:00:00"
  },
  {
    "id": 4,
    "type": "break",
    "start_time": "2024-10-03T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-03T12:30:00"
  },
  {
    "id": 5,
    "type": "work",
    "start_time": "2024-10-07T09:00:00",
    "user_id": 1,
    "end_time": "2024-10-07T17:00:00"
  },
  {
    "id": 6,
    "type": "break",
    "start_time": "2024-10-07T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-07T12:30:00"
  },
  {
    "id": 7,
    "type": "work",
    "start_time": "2024-10-10T09:00:00",
    "user_id": 1,
    "end_time": "2024-10-10T17:00:00"
  },
  {
    "id": 8,
    "type": "break",
    "start_time": "2024-10-10T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-10T12:30:00"
  },
  {
    "id": 9,
    "type": "work",
    "start_time": "2024-10-12T09:00:00",
    "user_id": 1,
    "end_time": "2024-10-12T17:00:00"
  },
  {
    "id": 10,
    "type": "break",
    "start_time": "2024-10-12T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-12T12:30:00"
  },
  {
    "id": 11,
    "type": "work",
    "start_time": "2024-10-14T09:00:00",
    "user_id": 1,
    "end_time": "2024-10-14T17:00:00"
  },
  {
    "id": 12,
    "type": "break",
    "start_time": "2024-10-14T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-14T12:30:00"
  },
  {
    "id": 13,
    "type": "work",
    "start_time": "2024-10-18T09:00:00",
    "user_id": 1,
    "end_time": "2024-10-18T17:00:00"
  },
  {
    "id": 14,
    "type": "break",
    "start_time": "2024-10-18T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-18T12:30:00"
  },
  {
    "id": 15,
    "type": "work",
    "start_time": "2024-10-21T09:00:00",
    "user_id": 1,
    "end_time": "2024-10-21T17:00:00"
  },
  {
    "id": 16,
    "type": "break",
    "start_time": "2024-10-21T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-21T12:30:00"
  }
]
)



let paidOvertimeRatio= `${paidOvertime}%`
let nightShiftsRatio= `${nightShifts}%`

console.log(store.user);


</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <div class="graph-container">
      <div class="graph small-graph">
        <h2 class="roboto-bold">Today</h2>
        <p>lalal</p>
      </div>
      <div class="graph small-graph">
        <h2 class="roboto-bold">Details</h2>
        <p>Mandatory hours : 8:30 - 12:30 / 14:00 - 17:00</p>
        <p>Paid overtime available : 4 hours</p>
        <div class="progress-outside"><div class="progress-inside paid-overtime"></div></div>
        <p>Unpaid overtime done : 0 hours</p>
        <p>Night shifts worked this week : 1</p>
        <div class="progress-outside"><div class="progress-inside night-shifts"></div></div>
      </div>
    </div>
    <div class="graph big-graph">
      <h2 class="roboto-bold">The past 7 days</h2>
      <TimeChart :working-hours="props" />
    </div>
  </div>
</template>

<style>


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
  box-shadow: 0px 4px 9px 3px rgba(2,2,0,0.4);
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

.small-graph{
  width: 48%;
  height: 100%;
}

.small-graph h2, .big-graph h2 {
  font-size: 36px;
}

.progress-outside{
  height: 25px;
  width: 300px;
  /* background-color: #b6b5b5; */
  background-color: #b6b5b560;
  border-radius: 15px;
}

.progress-inside{
  height: 100%;
  border-radius: 15px;
}

.paid-overtime {
  background-color: #F2BC0F;
  width: v-bind('paidOvertimeRatio');
}

.night-shifts {
  background-color: #e80c13;
  width: v-bind('nightShiftsRatio');
}

.small-graph p {
align-self: flex-start;
}

@media (max-width:940px)  {
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