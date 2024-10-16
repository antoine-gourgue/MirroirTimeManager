<script setup>

import AppBanner from './banner/AppBanner.vue';
import SideBar from './sidebar/SideBar.vue';

</script>

<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
  </div>
</template>

<style>
.main-container {
  width: 100%;
  height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--light);
}
</style>