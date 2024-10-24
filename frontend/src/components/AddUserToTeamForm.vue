<script setup>

import { ref } from 'vue';
import { mockUsers } from '../../public/mockData';
import AppBanner from './banner/AppBanner.vue';
import SearchBar from './SearchBar.vue';
import SideBar from './sidebar/SideBar.vue';
import UserTable from './UserTable.vue';
import { getTeamById } from '@/services/api';

let user = mockUsers[0]
let selectedUserId = ref('')

// let currentTeam = ref(await getTeamById(2))
// console.log("Current team :", currentTeam);




function cancelButton() {
  Swal.fire({
    icon: 'info',
    title: 'Request cancelled!',
    text: 'No day off requested',
  });
  router.push('/user/dashboard');
}

async function addNewUserToTeam(){

}

</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Add a new team member</h2>
    <p class="page-subtitle">Team Patapon :</p>

    <UserTable />
    <form action="">
      <div class="form-section">
        <div class="form-idUser">
          <label for="selectedUser">Selected user's ID :</label>
          <input type="text" name="selectedUser" id="selectedUser" v-model="selectedUserId">
        </div>

      </div>
    </form>
    <div class="buttons-container-row">
      <button class="custom-button form-button-big green">Confirm</button>
      <button class="custom-button form-button-small yellow" @click="cancel">Cancel</button>
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