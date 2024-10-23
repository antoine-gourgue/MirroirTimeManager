<script setup>
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import InputText from 'primevue/inputtext';
import { RouterLink } from 'vue-router';
import { ref, computed } from 'vue';
import { deleteUser, getAllUsers } from '@/services/api';
import Swal from 'sweetalert2';
import router from '@/router';

const usersRaw = ref(await getAllUsers())
const users = usersRaw._rawValue.data.data
// console.log(users);

const searchTerm = ref('');

const filteredUsers = computed(() => {
    return users.filter(user => {
        return (
            user.username.toLowerCase().includes(searchTerm.value.toLowerCase()) ||
            user.email.toLowerCase().includes(searchTerm.value.toLowerCase())
        );
    });
});

const deleteUserFromTable = async (userId) => {
    const result = await Swal.fire({
        title: 'Are you sure?',
        text: "Do you really want to delete this user?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#3085d6',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'No, cancel!',
    });

    if (result.isConfirmed) {
        console.log("Delete user with ID:", userId);
        await deleteUser(userId); // Wait for the delete operation
        Swal.fire('Deleted!', 'The user has been deleted.', 'success');
        window.location.reload()
    } else {
        Swal.fire('Cancelled', 'The user was not deleted.', 'info');
    }
};
</script>

<template>
    <div>
        <InputText 
            v-model="searchTerm" 
            placeholder="Search by username or email" 
            style="margin-bottom: 1rem;"
        />
        <RouterLink to="/user/create"><img src="../assets/add-green.svg" alt="" class="create-button"></RouterLink>

        <DataTable 
            :value="filteredUsers" 
            tableStyle="min-width: 50rem" 
            scrollable 
            scrollHeight="350px" 
            paginator 
            :rows="5" 
            :rowsPerPageOptions="[5, 10, 20, 50]"
        >
            <Column field="id" header="ID" sortable style="width: 10%"></Column>
            <Column field="username" header="Username" sortable style="width: 25%"></Column>
            <Column field="email" header="Email" sortable style="width: 30%"></Column>
            <!-- <Column field="teams_id" header="Teams ID" sortable style="width: 15%"></Column> -->
            <Column field="role_id" header="Role" sortable style="width: 15%"></Column>
            <Column header="Actions" style="width: 10%">
              <template #body="slotProps">
                <RouterLink :to="`/user/modifyAnotherUser/${slotProps.data.id}`"><img src="../assets/pencil_1.png" class="table-button" alt=""></RouterLink>
                
                <img src="../assets/trash_2.png" class="table-button" alt="" @click="deleteUserFromTable(slotProps.data.id)">
              </template>
            </Column>
        </DataTable>
    </div>
</template>

<style>
.table-button {
  margin-right: 5px;
  height: 20px;
  cursor: pointer;
}
</style>
