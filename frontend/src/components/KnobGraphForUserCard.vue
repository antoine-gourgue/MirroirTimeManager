<script setup>
import Knob from 'primevue/knob';
import { computed, ref, watch } from 'vue';

const props = defineProps(['percentageOfWorkedHours']);
let value = ref(props.percentageOfWorkedHours);

watch(
    () => props.percentageOfWorkedHours,
    (newValue) => {
      value.value = newValue;
    }
);

const blobColor = computed(() => {
  if (value.value > 100) {
    return '#d20d0d';
  } else if (value.value >= 75) {
    return '#0e9604';
  } else if (value.value >= 50) {
    return '#dfc51c';
  } else {
    return '#f1a546';
  }
});

const formattedValue = computed(() => value.value.toFixed(1));

const workedTime = computed(() => {
  const totalMinutes = (value.value / 100) * 7 * 60;
  const hours = Math.floor(totalMinutes / 60);
  const minutes = Math.round(totalMinutes % 60);
  return `${hours}h ${minutes}min`;
});
</script>

<template>
  <div class="knob-container">
    <Knob
        v-model="value"
        :valueTemplate="`${formattedValue}%`"
        :valueColor="blobColor"
        :rangeColor="'#e0e0e0'"
        :size="140"
        :strokeWidth="12"
        :showValue="true"
        readonly
    />
    <div class="tooltip">
      <span class="tooltip-text">{{ workedTime }}</span>
    </div>
  </div>
</template>

<style scoped>
.knob-container {
  position: relative;
  display: inline-block;
  text-align: center;
  margin-left: 20px;
}

.tooltip {
  position: absolute;
  top: 50%;
  left: 100%;
  transform: translate(10px, -50%);
  background-color: rgba(0, 0, 0, 0.75);
  color: #fff;
  border-radius: 5px;
  padding: 6px 12px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.2s ease-in-out;
  white-space: nowrap;
  z-index: 10;
}

.tooltip::after {
  content: '';
  position: absolute;
  top: 50%;
  right: 100%;
  transform: translateY(-50%);
  border-width: 6px;
  border-style: solid;
  border-color: transparent transparent transparent rgba(0, 0, 0, 0.75);
}

.knob-container:hover .tooltip {
  opacity: 1;
}

.tooltip-text {
  font-size: 14px;
  font-weight: bold;
}
</style>
