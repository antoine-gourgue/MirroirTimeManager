<script setup>
import { onMounted, ref } from 'vue';
import { getUserById } from '@/services/api';
import { store } from '@/services/store';
import Swal from 'sweetalert2';

let mockRole = "super_manager"
let user = ref('')

const requestUser = await getUserById(sessionStorage.user_id);
  user = requestUser.data.data; // Set the user data

  function logout() {
  sessionStorage.removeItem('token');
  sessionStorage.removeItem('user_id');
  sessionStorage.removeItem('role_id');

  Swal.fire({
    icon: 'success',
    title: 'Logout successful!',
    text: 'You have been logged out.',
  });

  // router.push('/');
  
}
</script>

<template>
  <header >
    <img src=".././../assets/images/batman.svg" alt="" srcset="" class="avatar" />
    <h2 class="username" v-if="user">{{ user.username }}</h2>
    <nav class="navlist">
      <RouterLink to="/user/dashboard" class="nav-link">Personal dashboard</RouterLink>
      <RouterLink to="/user/modify" class="nav-link">Account settings</RouterLink>
      <RouterLink to="/user/requestDayOff" class="nav-link">Take a day off</RouterLink>
      <RouterLink class="nav-link" to="/manager/dashboard" v-if="user.role_id === 2 || user.role_id === 1">Team management</RouterLink>
      <RouterLink class="nav-link" to="/topManager/dashboard" v-if="user.role_id === 1">Top manager dashboard</RouterLink>
      <RouterLink to="/" class="nav-link" @click="logout">Log out</RouterLink>
    </nav>
  </header>
</template>

<style>
@import url(../../assets/base.css);
header {
  width: 250px;
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  background-color: var(--dark);
  color: var(--light);
  padding: 15px;
}

.avatar {
  width: 150px;
  height: 150px;
  margin-bottom: 15px;
  align-self: center;
}

.username {
  align-self: center;
  margin-bottom: 30px;
  font-size: 32px;
}

.navlist {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.navlist .nav-link, .navlist button {
  text-decoration: none;
  color: var(--light);
  font-size: 20px;
  width: 95%;
  min-height: 35px;
  padding: 5px;
  border-radius: 0 5px 0 0;
  margin-top: 25px;
  text-wrap: wrap;
  border: none;
  border-bottom: 2px solid rgba(0, 0, 0, 0);
  background: none;
}

.navlist .nav-link:hover, .navlist button:hover {
  color: var(--main);
  border-bottom: 2px solid var(--main);
  background: linear-gradient(
    90deg,
    rgba(254, 254, 254, 0) 0%,
    rgba(255, 255, 255, 0) 24%,
    rgba(0, 0, 0, 0.476) 100%
  );
}

@media (max-width:940px) {
  header {
    display: none;
  }
}
</style>
