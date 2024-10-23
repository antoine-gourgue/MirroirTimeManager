<script setup>

import { onMounted, ref } from 'vue';
import { mockUsers } from '../../public/mockData';
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import { useRouter } from 'vue-router';
import Swal from 'sweetalert2';
import { createWorkingTime, getUserById } from '@/services/api';
import DatePicker from 'primevue/datepicker';

const user = ref(null);
const router = useRouter()

onMounted(async () => {
  const requestUser = await getUserById(sessionStorage.user_id);
  user.value = requestUser.data.data; 
});

function cancelButton() {
  Swal.fire({
    icon: 'info',
    title: 'Request cancelled!',
    text: 'No day off requested',
  });
  router.push('/user/dashboard');
}


let selectedOption = ref(null)
let startTime = ref(null)
let endTime = ref(null)

function formatDate(dateStr) {
  if(dateStr !== null) {
    const date = new Date(dateStr)
    const isoString = date.toISOString()
    return isoString
  }
  return null
}

async function submitDayOffForm(){
  if(selectedOption.value === null || startTime.value === null || endTime.value === null){
    Swal.fire({
    icon: 'info',
    title: 'Request cancelled!',
    text: 'No day off requested',
  });
  } else {
    const params = {
    type: selectedOption.value,
    start_time: formatDate(startTime.value),
    end_time: formatDate(endTime.value),
    user_id: sessionStorage.user_id
  }

  let blob = await createWorkingTime(params)
  console.log(blob);

  Swal.fire({
    icon: 'success',
    title: 'Request successful!',
    text: 'You successfully asked for a day off',
  });

  router.push('/user/dashboard');
  }  


}

</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Manage your time</h2>
    <p class="page-subtitle" v-if="user">Hello, {{ user.username }} !</p>
    <p class="page-subtitle">Please, fill this form to be allowed to take a day off</p>
    <form action="">
      <label for="email">Reason :</label>
      <select v-model="selectedOption" name="reason" id="reason">
        <option value="dayOff">Day off</option>
        <option value="sickLeave">Sick leave</option>
      </select>
      <div class="form-section">
        <div class="date-input">
          <label for="start_time">Start time :</label>
          <DatePicker id="startTimeInput" v-model="startTime" showTime hourFormat="24" fluid />
        </div>
        <div class="date-input">
          <label for="end_time">End time :</label>
          <DatePicker id="endTimeInput" v-model="endTime" showTime hourFormat="24" fluid />
        </div>

      </div>
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green" @click="submitDayOffForm">Confirm</button>
      <button class="custom-button form-button-small yellow" @click="cancelButton">Cancel</button>
    </div>
  </div>
</template>

<style>

select {
  border: 1px solid rgba(0, 0, 0, 0.144);
  border-radius: 8px;
  height: 40px;
  padding: 5px;
}

.form-section {
  margin-top: 15px;
  width: 100%;
  
  display: flex;
  justify-content: space-between;
}
.date-input{
  width: 45%;
}

.date-input input {
  width: 100%;
  margin-top: 8px;
}

</style>