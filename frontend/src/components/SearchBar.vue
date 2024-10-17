<script setup>
const props = defineProps({placeholder: String})

console.log(props.placeholder);

</script>

<template>
  <div class="searchbar-container">
    <input type="text" placeholder="Temporary placeholder" class="searchbar">
    <img src="../assets/search.svg" alt="" class="searchbar-icon">
  </div>

</template>

<style>
.searchbar-container {
  height: 50px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.searchbar {
  width: 300px;
  height: 50px;
  margin-top: 15px;
  border-radius: 25px;
  padding: 15px;
}

.searchbar-icon{
height: 25px;
position: relative;
left: -45px;
top:6px
}

.searchbar-icon:hover{
  transform: scale(110%);
}
</style>