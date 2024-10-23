<script setup>
import { ref, onMounted } from 'vue';
import { getUserById, modifyUser } from '@/services/api';
import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';
import Swal from 'sweetalert2';
import { useRouter } from 'vue-router';

const user = ref(null);
const router = useRouter()

onMounted(async () => {
  const requestUser = await getUserById(sessionStorage.user_id);
  user.value = requestUser.data.data; 
  console.log(user.value);
});

async function modifySettings() {
  console.log('Before :', user);
  
  const newUsername = document.getElementById('username').value || user.value.username;
  const newEmail = document.getElementById('email').value || user.value.email;

  await modifyUser(sessionStorage.user_id, {
    username: newUsername,
    email: newEmail,
  });
  console.log('After :', user._rawValue);

  Swal.fire({
          icon: 'success',
          title: 'Change successful!',
          text: 'You successfully modified your profile',
        });

        router.push('/user/dashboard');
}
function cancelButton() {
  Swal.fire({
    icon: 'success',
    title: 'Change cancelled!',
    text: 'You cancelled the changes',
  });
  router.push('/user/dashboard');
}
</script>

<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <h2 class="page-title">Account settings</h2>
    <p class="page-subtitle" v-if="user">Hello, {{ user.username }} !</p>
    <p class="page-subtitle">You can modify your account informations</p>
    <form action="">
      <label for="email">Email :</label>
      <input v-if="user" type="email" name="email" id="email" :v-model="user.email" :value="user.email">
      <label for="username">Username :</label>
      <input v-if="user" type="text" name="username" id="username" :v-model="user.username" :value="user.username">
    </form>
    <div class="buttons-container">
      <button class="custom-button form-button-big green" @click="modifySettings">Confirm</button>
      <button class="custom-button form-button-small yellow" @click="cancelButton">Cancel</button>
    </div>
  </div>
</template>

<style>
.page-title {
  font-size: 48px;
  margin: 15px;
}

.page-subtitle {
  font-size: 20px;
  font-weight: 300;
  word-wrap: break-word;
}

form {
  width: 450px;
  margin: 45px;
  display: flex;
  flex-direction: column;
}

label {
  margin-top: 20px;
  margin-bottom: 8px;
  font-weight: 500;
}

input {
  border: 1px solid rgba(0, 0, 0, 0.144);
  border-radius: 8px;
  height: 40px;
  padding: 15px;
}

.yellow {
  background-color: rgb(216, 183, 18);
}

.form-button-big {
  justify-content:  center;
  transform: scale(0.8);
}

.form-button-small {
  justify-content:  center;
  transform: scale(0.6);
}

@media (max-width:940px) {
  .main-container {
    min-height: 100vh;
  }

  form {
    width: 90%;
  }

  
  input {
    align-self: center;
    width: 100%;
  }

  .page-title {
    font-size: 34px;
  }

  .page-subtitle {
    font-size: 16px;
  }
}
</style>