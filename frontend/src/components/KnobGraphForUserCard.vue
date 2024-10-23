<script setup>
import Knob from 'primevue/knob';
import { computed, ref } from 'vue';

const props = defineProps(['percentageOfWorkedHours'])
let value = ref(props.percentageOfWorkedHours)

const blobColor = computed(() => {
  if (value.value > 100) {
    return '#d20d0d';
  } else if (value.value >= 75) {
    return '#0e9604';
  } else {
    return '#dfc51c';
  }
});

</script>

<template>
  <Knob v-model="value" valueTemplate="{value}%" :valueColor="blobColor" readonly  />
</template>

<style>


</style>