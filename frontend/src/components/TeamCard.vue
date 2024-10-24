<script setup>
import { RouterLink } from 'vue-router';

const props = defineProps({
  teamName: {
    type: String,
  },
  teamId: {
    type: String,
  }
})
</script>

<template>
  <RouterLink :to="`/manager/team/${teamId}`" class="team-card">Team {{ teamName }}</RouterLink>
   <!-- <div>lol</div> -->
</template>

<style>
</style>