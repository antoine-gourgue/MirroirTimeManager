<script setup>

import AppBanner from './banner/AppBanner.vue';
import SearchBar from './SearchBar.vue';
import SideBar from './sidebar/SideBar.vue';

import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import ColumnGroup from 'primevue/columngroup';   // optional
import Row from 'primevue/row';                   // optional
import { mockUsers } from '../../public/mockData';


</script>

<template>
  <SideBar />
  <div class="main-container">
    <AppBanner />
    <div class="team-container">
        <div class="team-card">
          <h3>Team Patapon</h3>
          <!-- <img src="../assets/night-shift-warning.png" alt="" class="nightshift-warning"> -->
        </div>
      <RouterLink to="/team/manage" class="team-card">Team Patapon</RouterLink>
      <div class="team-card">Team Patapon</div>
      <div class="team-card">Team Patapon</div>
    </div>
    <SearchBar placeholder="Tibidi" />
    <div class="table-container">
      <DataTable :value="mockUsers" tableStyle="min-width: 50rem" scrollable scrollHeight="350px" paginator :rows="5" :rowsPerPageOptions="[5, 10, 20, 50]">
      <Column field="id" header="ID" sortable style="width: 10%"></Column>
      <Column field="username" header="Username" sortable style="width: 25%"></Column>
      <Column field="email" header="Email" sortable style="width: 35%"></Column>
      <Column field="teams_id" header="Teams ID" sortable style="width: 25%"></Column>
    </DataTable>
    </div>


  </div>
</template>

<style>

.team-container {
  width: 100%;
  height: 225px;
  border-bottom: 2px solid rgba(0, 0, 0, 0.239);
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  overflow-x:auto;
  white-space: nowrap;
  flex-wrap: nowrap;
}

.table-container {
  width: 90%;
  height: auto;
}


.team-card {
  text-decoration: none;
  color: black;
  width: 200px;
  height: 200px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  border: 2px solid rgba(0, 0, 0, 0.301);
  background-color: white;
  border-radius: 8px;
  font-weight: 600;
  font-size: 24px;
  margin: 15px;
  /* padding-top: 26px; */
} 

/* .nightshift-warning{
  position: relative;
  top: 85px;
  left: ;
} */

</style>