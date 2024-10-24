<script setup>
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import InputText from 'primevue/inputtext';
import { ref, computed } from 'vue';
import { mockTeams } from '../../public/mockData'; // Assume mockTeams contains your teams data
import Button from 'primevue/button';
import { deleteTeam, getAllTeams } from '@/services/api';
import Swal from 'sweetalert2';

const teamsRaw = ref(await getAllTeams())
const teams = teamsRaw._rawValue.data.data
console.log(teams);


const searchTerm = ref('');

const filteredTeams = computed(() => {
    return teams.filter(team => {
        return (
            team.name.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
            team.teamManager.toLowerCase().includes(searchTerm.value.toLowerCase())
        );
    });
});

const deleteTeamFromTable = async (teamId) => {
    const result = await Swal.fire({
        title: 'Are you sure?',
        text: "Do you really want to delete this team?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'No, cancel!',
    });

    if (result.isConfirmed) {
        try {
            console.log("Delete team with ID:", teamId);
            await deleteTeam(teamId);
            Swal.fire('Deleted!', 'The team has been deleted.', 'success');
            // Refresh the data here if needed
        } catch (error) {
            Swal.fire('Error!', 'There was an error deleting the team.', 'error');
        }
    } else {
        Swal.fire('Cancelled', 'The team was not deleted.', 'info');
    }
};

</script>

<template>
    <div>
        <InputText 
            v-model="searchTerm" 
            placeholder="Search by team name or manager" 
            style="margin-bottom: 1rem;"
        />
        <RouterLink to="/team/create"><img src="../assets/add-green.svg" alt="" class="create-button"></RouterLink>

        <DataTable 
            :value="filteredTeams" 
            tableStyle="min-width: 50rem" 
            scrollable 
            scrollHeight="350px" 
            paginator 
            :rows="5" 
            :rowsPerPageOptions="[5, 10, 20, 50]"
        >
            <Column field="id" header="Team ID" sortable style="width: 15%"></Column>
            <Column field="name" header="Name" sortable style="width: 35%"></Column>
            <Column field="manager_id" header="Team Manager's ID" sortable style="width: 20%"></Column>
            <!-- <Column field="numberOfEmployees" header="Number of Employees" sortable style="width: 20%"></Column> -->
            <Column header="Actions" style="width: 10%">
              <template #body="slotProps">
                <RouterLink to="/team/modify"><img src="../assets/pencil_1.png" class="table-button" alt=""></RouterLink>
                <img src="../assets/trash_2.png" class="table-button" alt="" @click="deleteTeamFromTable(slotProps.data.id)">
              </template>
            </Column>
        </DataTable>
    </div>
</template>

<style></style>
