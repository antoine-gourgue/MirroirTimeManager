<script setup>

import { ref } from 'vue';
import { createTeam } from '@/services/api';
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import Swal from 'sweetalert2';
import { useRouter } from 'vue-router';

const newTeam = ref({
  name: '',
  manager_id: 0
})
const router = useRouter()

console.log(sessionStorage.token);


async function createNewTeam() {
  try {
    console.log(newTeam.value);
    
    const response = await createTeam(newTeam.value);

    // Check if the response indicates success
    if (response && response.status === 201) {
      Swal.fire({
        icon: 'success',
        title: 'Team created',
        text: 'You successfully created a new team',
      });
      router.push('/topManager/dashboard');
    } else {
      // Handle cases where the response indicates an error
      Swal.fire({
        icon: 'error',
        title: 'Error!',
        text: response?.data?.message || 'There was an error while creating a team',
      });
    }
    
  } catch (error) {
    console.error('Error creating team:', error.response ? error.response.data : error.message);
    Swal.fire({
      icon: 'error',
      title: 'Error!',
      text: 'There was an error while creating a team',
    });
  }
}


function cancelButton() {
  Swal.fire({
    icon: 'info',
    title: 'Change cancelled!',
    text: 'You cancelled the creation',
  });
  router.push('/topManager/dashboard');
}


</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Create a new team</h2>
    <form action="">
      <label for="name">Name :</label>
      <input type="text" name="name" id="name" v-model="newTeam.name">
      <label for="managerId">Manager id :</label>
      <input type="number" name="managerId" id="manager" v-model="newTeam.manager_id">
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green" @click="createNewTeam">Confirm</button>
      <button class="custom-button form-button-small yellow" @click="cancelButton">Cancel</button>
    </div>
  </div>
</template>

<style>
</style>