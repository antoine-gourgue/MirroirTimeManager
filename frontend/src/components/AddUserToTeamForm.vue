<script setup>

import { ref } from 'vue';
import { mockUsers } from '../../public/mockData';
import AppBanner from './banner/AppBanner.vue';
import SearchBar from './SearchBar.vue';
import SideBar from './sidebar/SideBar.vue';
import UserTable from './UserTable.vue';
import { addUserToTeam, getTeamById } from '@/services/api';
import Swal from 'sweetalert2';
import { useRoute, useRouter } from 'vue-router';

let user = mockUsers[0]
let selectedUserId = ref(0)
let router = useRouter()
let route = useRoute()

let currentTeamRaw = ref(await getTeamById(route.params.id))
let currentTeam = currentTeamRaw._rawValue.data.data
console.log("Current team :", currentTeam);

function cancelButton() {
  Swal.fire({
    icon: 'info',
    title: 'Request cancelled!',
    text: 'No team member added',
  });
  router.push(`/manager/team/${currentTeam.id}`);
}

async function addNewUserToTeam(){
  try {
    let newTeamUser = {
      user_id: selectedUserId.value,
      team_id: currentTeam.id
    }
    console.log(newTeamUser);
    
    const response = await addUserToTeam(newTeamUser);

    // Check if the response indicates success
    if (response && response.status === 201) {
      Swal.fire({
        icon: 'success',
        title: 'User added',
        text: 'You successfully added a new user to the team',
      });
      router.push(`/manager/team/${currentTeam.id}`);
      console.log(response);
      
    } else {
      // Handle cases where the response indicates an error
      Swal.fire({
        icon: 'error',
        title: 'Error!',
        text: response?.data?.message || 'There was an error while adding a user to the team',
      });
    }
    
  } catch (error) {
    console.error('Error creating team:', error.response ? error.response.data : error.message);
    Swal.fire({
      icon: 'error',
      title: 'Error!',
      text: 'There was an error while adding a user to the team',
    });
  }
}

</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Add a new team member</h2>
    <p class="page-subtitle">Team {{ currentTeam.name }} :</p>

    <UserTable />
    <form action="">
      <div class="form-section">
        <div class="form-idUser">
          <label for="selectedUser">Selected user's ID :</label>
          <input type="number" name="selectedUser" id="selectedUser" v-model="selectedUserId">
        </div>

      </div>
    </form>
    <div class="buttons-container-row">
      <button class="custom-button form-button-big green" @click="addNewUserToTeam">Confirm</button>
      <button class="custom-button form-button-small yellow" @click="cancelButton">Cancel</button>
    </div>
  </div>
</template>

<style>
.buttons-container-row {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  margin-bottom: 25px;
  width: 100%;
}
.form-idUser{
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  width: 100%;
}
</style>