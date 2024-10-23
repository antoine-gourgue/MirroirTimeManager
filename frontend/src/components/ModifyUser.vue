<script setup>
import { ref, onMounted } from 'vue';
import { getUserById, modifyUser } from '@/services/api';
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import Swal from 'sweetalert2';
import { useRoute, useRouter } from 'vue-router';

const selectedUser = ref(null);
const router = useRouter()
const route = useRoute()

onMounted(async () => {
  const requestUser = await getUserById(route.params.id);
  selectedUser.value = requestUser.data.data;
  console.log(selectedUser.value);
});

async function modifySettings() {
  try {

    const newUsername = selectedUser.value.username;
    const newEmail = selectedUser.value.email;


    
    await modifyUser(selectedUser.value.id, {
      username: newUsername,
      email: newEmail,
    });
  

    Swal.fire({
      icon: 'success',
      title: 'Change successful!',
      text: 'You successfully modified the profile of this user',
    });

    router.push('/topManager/dashboard');
  } catch (error) {
    console.error('Error modifying user:', error);
    Swal.fire({
      icon: 'error',
      title: 'Error!',
      text: 'There was an error modifying the user profile.',
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
    <h2 class="page-title">Account settings</h2>
    <p class="page-subtitle" v-if="selectedUser"> Change {{ selectedUser.username }}'s informations' !</p>
    <form action="">
      <label for="email">Email :</label>
      <input v-if="selectedUser" type="email" name="email" id="email" v-model="selectedUser.email" />
      <label for="username">Username :</label>
      <input v-if="selectedUser" type="text" name="username" id="username" v-model="selectedUser.username" />
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green" @click="modifySettings">Confirm</button>
      <button class="custom-button form-button-small yellow" @click="cancelButton">Cancel</button>
    </div>
  </div>
</template>

<style>
</style>