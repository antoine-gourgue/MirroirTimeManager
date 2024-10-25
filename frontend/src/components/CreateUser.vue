<script setup>

import { ref } from 'vue';
import { createUser } from '@/services/api';
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import Swal from 'sweetalert2';
import { useRouter } from 'vue-router';

const newUser = ref({
  username: '',
  email: '',
  password: '',
  role_id: null,
})
const router = useRouter()

async function createNewUser() {
  try {

    console.log(newUser);
    
    await createUser(newUser.value);
  

    Swal.fire({
      icon: 'success',
      title: 'User created',
      text: 'You successfully modified the profile of this user',
    });

    router.push('/topManager/dashboard');
  } catch (error) {
    console.error('Error modifying user:', error);
    Swal.fire({
      icon: 'error',
      title: 'Error!',
      text: 'There was an error while creating a user',
    });
  }
}

function cancelButton() {
  Swal.fire({
    icon: 'success',
    title: 'Change cancelled!',
    text: 'You cancelled the changes',
  });
  router.push('/topManager/dashboard');
}



</script>




<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Create a new user</h2>
    <form action="">
      <label for="email">Email :</label>
      <input type="email" name="email" id="email" v-model="newUser.email">
      <label for="username">Username :</label>
      <input type="text" name="username" id="username" v-model="newUser.username">
      <label for="password">Password :</label>
      <input type="password" name="password" id="password" v-model="newUser.password">
      <label for="role">Role :</label>
      <select name="role" id="role" v-model="newUser.role_id">
        <option value="3">User</option>
        <option value="2">Manager</option>
        <option value="1">Top manager</option>
      </select>
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green" @click="createNewUser">Confirm</button>
      <button class="custom-button form-button-small yellow" @click="cancelButton">Cancel</button>
    </div>
  </div>
</template>

<style>
</style>