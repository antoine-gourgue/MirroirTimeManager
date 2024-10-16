<script setup>
import { mockUsers } from '../../../public/mockData'

let user = mockUsers[0]
let mockRole = "user"
</script>

<template>
  <header>
    <img src=".././../assets/images/batman.svg" alt="" srcset="" class="avatar" />
    <h2 class="username">{{ user.username }}</h2>
    <nav class="navlist">
      <RouterLink to="/dashboardUser" class="nav-link">Dashboard</RouterLink>
      <RouterLink to="/requestDayOff" class="nav-link">Take a day off</RouterLink>
      <p v-if="mockRole === 'manager' || mockRole === 'super_manager'">Team management</p>
      <p v-if="mockRole === 'super_manager'">Userbase management</p>
      <RouterLink to="/modifyUser" class="nav-link">Account settings</RouterLink>
      <p>About</p>
      <p>Contact</p>
      <p>Log out</p>
    </nav>
  </header>
</template>

<style>
@import url(../../assets/base.css);
header {
  width: 250px;
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  background-color: var(--dark);
  color: var(--light);
  padding: 15px;
}

.avatar {
  width: 150px;
  height: 150px;
  margin-bottom: 15px;
  align-self: center;
}

.username {
  align-self: center;
  margin-bottom: 30px;
  font-size: 32px;
}

.navlist {
  display: flex;
  flex-direction: column;
  height: 30vh;
  justify-content: space-between;
}

.navlist .nav-link, .navlist p {
  text-decoration: none;
  color: var(--light);
  font-size: 20px;
  width: 95%;
  height: 35px;
  padding: 5px;
  border-radius: 0 5px 0 0;
}

.navlist .nav-link:hover, .navlist p:hover {
  color: var(--main);
  border-bottom: 2px solid var(--main);
  background: linear-gradient(
    90deg,
    rgba(254, 254, 254, 0) 0%,
    rgba(255, 255, 255, 0) 24%,
    rgba(0, 0, 0, 0.476) 100%
  );
}

/* .nav-link {
  text-decoration: none;
  color: var(--light);
} */

@media (max-width:940px) {
  header {
    display: none;
  }
}
</style>
