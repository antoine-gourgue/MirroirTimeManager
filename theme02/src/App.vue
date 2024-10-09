<template>
  <div id="app" class="min-h-screen bg-gray-100 text-gray-800 p-4">
    <div class="container mx-auto">
      <User />
      <WorkingTimes />
      <WorkingTime />
      <ClockManager />
      <ChartManager />
    </div>
  </div>
</template>

<script setup>
import User from './components/User.vue';
import WorkingTimes from './components/WorkingTimes.vue';
import WorkingTime from './components/WorkingTime.vue';
import ClockManager from './components/ClockManager.vue';
import ChartManager from './components/ChartManager.vue';
</script>

<style>
/* Style global */
</style>
