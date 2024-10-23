<script setup>
import UserDashboard from '../components/UserDashboard.vue'
</script>

<template>
  <main>
    <Suspense>
      <UserDashboard />
    </Suspense>
    
  </main>
</template>

<style>
main {
  display: flex;
  flex-direction: row;
}
</style>