<template>
  <main class="landing-container">
    <div class="welcome">
      <h2>Welcome to Time Manager</h2>
      <p>Please, log in using the credentials provided by your team manager</p>
      <form @submit.prevent="validateLoginForm">
        <label for="email">Email:</label>
        <input type="email" v-model="email" required />

        <label for="password">Password:</label>
        <input type="password" v-model="password" required />

        <button class="login-button" type="submit">Log in</button>
      </form>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
      <RouterLink to="/user/dashboard">Go to the user's dashboard</RouterLink>
      <RouterLink to="/signUp">Register to Time Manager</RouterLink>
    </div>
  </main>
</template>

<script setup>
import { ref } from 'vue';
import { login } from '@/services/api';
import {jwtDecode} from "jwt-decode";
import Swal from 'sweetalert2';
import router from '@/router';

let email = ref('');
let password = ref('');
let errorMessage = ref('');

function validateLoginForm() {
  login({ email: email.value, password: password.value })
      .then(data => {
        console.log('Login successful:', data);
        const token = data.token;
        sessionStorage.setItem('token', token);

        const decodedToken = jwtDecode(token);
        sessionStorage.setItem('user_id', decodedToken.sub);
        sessionStorage.setItem('role_id', decodedToken.role_id);

        Swal.fire({
          icon: 'success',
          title: 'Login successful!',
          text: 'You are now logged in.',
        });

        router.push('/user/dashboard');
      })
      .catch(error => {
        errorMessage.value = 'Login failed. Please check your credentials.';
        console.error(error);
      });
}
</script>

<style>
.landing-container {
  width: 100vw;
  height: 100vh;
  background-image: url('../assets/images/gotham-city.jpg');
  background-position: center;
  background-size: cover;
  display: flex;
  justify-content: center;
  align-items: center;
}

.welcome {
  width: 50%;
  min-height: 50%;
  background-color: rgba(0, 0, 0, 0.831);
  color: var(--light);
  border-radius: 15px;
  padding: 25px;
  display: flex;
  flex-direction: column;
  align-items: center;
  box-shadow: 2px 2px 6px 1px rgba(108, 108, 108, 0.315);
}

.welcome h2 {
  font-size: 36px;
  font-weight: 600;
  margin-bottom: 15px;
  text-align: center;
}

.welcome p {
  font-size: 18px;
  font-weight: 300;
  font-style: italic;
  text-align: center;
}

.login-button {
  width: 95px;
  height: 40px;
  background-color: green;
  border: none;
  border-radius: 8px;
  color: white;
  box-shadow: 2px 2px 6px 1px rgba(103, 103, 103, 0.315);
}

.error-message {
  color: red;
  margin-top: 10px;
}

@media (max-width: 650px) {
  .welcome {
    width: 90%;
  }
}
</style>