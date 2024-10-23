<script setup>
import { signUp } from '@/services/api';
import { ref } from 'vue';


let email = ref('')
let password = ref('')
let username = ref('')


function validateSignUpForm(){
  signUp({email: email.value, password: password.value, username: username.value})
  
  
}


</script>

<template>
  <main class="landing-container">
    <div class="welcome">
      <h2>Welcome in Time Manager</h2>
      <p>Please, log in using the credentials provided by your team manager</p>
      <form action="">
      <label for="email">Email :</label>
      <input type="email" name="email" id="email" v-model="email">
      <label for="username">Username :</label>
      <input type="text" name="username" id="username" v-model="username">
      <label for="password">Password :</label>
      <input type="password" name="password" id="password" v-model="password">
    </form>
    <button class="login-button" @click="validateSignUpForm" >Sign up</button>

    </div>

  </main>
</template>

<style>

</style>