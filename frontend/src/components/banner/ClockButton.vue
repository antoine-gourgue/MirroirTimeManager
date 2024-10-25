<script setup>
import { ref } from 'vue'
import { store } from '@/services/store';
import { createClock } from '@/services/api';

async function toggleTimer() {
  if (!store.clockState) {
    console.log(store.clockState);
    
    let params = {
      status: "IN",
      user_id: sessionStorage.user_id,
      time: new Date().toISOString()
    }
    await createClock(sessionStorage.user_id, params)
  } else {
    console.log(store.clockState);
    let params = {
      status: "OUT",
      user_id: sessionStorage.user_id,
      time: new Date().toISOString()
    }
    await createClock(sessionStorage.user_id, params)
  }

  store.toggleClockState()
}

let clockHasStarted = ref(false)
function toggleClock() {
  clockHasStarted.value = !clockHasStarted.value
}
</script>

<template>
  <button v-if="!store.clockState" @click="toggleTimer" class="custom-button green">
    Clock in <img src="../../assets/play.svg" alt="" class="play-icon" />
  </button>
  <button v-if="store.clockState" @click="toggleTimer" class="custom-button">
    Clock out <img src="../../assets/stop.svg" alt="" class="play-icon" />
  </button>
</template>

<style>
.custom-button {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-between;
  width: 200px;
  height: 70px;
  margin-right: 25px;
  padding: 0 15px 0 15px;
  border: none;
  border-radius: 5px;
  background-color: rgb(152, 3, 3);
  color: var(--light);
  font-size: 30px;
  cursor: pointer;
  box-shadow: 4px 4px 9px 3px rgba(0, 0, 0, 0.315);
}

button:hover {
  transform: scale(110%);
}

.green {
  background-color: #108f10;
}

.play-icon {
  margin-left: 10px;
  width: 30px;
  height: 30px;
}

@media (max-width:940px) {
  button {
    width: 140px;
    height: 45px;
    font-size: 16px;
    margin: 0;
  }
  .play-icon {
    width: 24px;
  }
}
</style>
