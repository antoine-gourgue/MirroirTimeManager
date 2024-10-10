<template>
  <div id="app" class="min-h-screen bg-gray-100 text-gray-800 p-4">
    <div class="container mx-auto">
      <UserList v-if="isAdmin"/>
      <User v-if="isAdmin" />
      <WorkingTimes v-if="isAdmin" />
      <WorkingTime v-if="isAdmin" />
      <ClockManager v-if="!isAdmin" />
      <ChartManager v-if="!isAdmin" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import User from '../components/User.vue';
import WorkingTimes from '../components/WorkingTimes.vue';
import WorkingTime from '../components/WorkingTime.vue';
import ClockManager from '../components/ClockManager.vue';
import ChartManager from '../components/ChartManager.vue';
import UserList from "../components/UserList.vue";

const isAdmin = ref(false);

onMounted(() => {
  isAdmin.value = localStorage.getItem('isAdmin') === 'true';
});
</script>

<style>
/* Style global */
</style>
