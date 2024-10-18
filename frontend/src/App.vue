<script setup>
import TeamAvgWorkingTime from "@/components/TeamAvgWorkingTime.vue";
</script>

<template>
  <TeamAvgWorkingTime :working-hours='
  [{
    "id": 1,
    "type": "work",
    "start_time": "2024-10-14T10:00:00",
    "user_id": 1,
    "end_time": "2024-10-14T16:00:00"
    },
    {
    "id": 2,
    "type": "break",
    "start_time": "2024-10-14T12:00:00",
    "user_id": 1,
    "end_time": "2024-10-14T12:30:00"
    },
    {
    "id": 1,
    "type": "work",
    "start_time": "2024-10-15T16:00:00",
    "user_id": 1,
    "end_time": "2024-10-15T20:00:00"
    },{
    "id": 1,
    "type": "work",
    "start_time": "2024-10-14T10:00:00",
    "user_id": 2,
    "end_time": "2024-10-14T16:00:00"
    },
    {
    "id": 2,
    "type": "break",
    "start_time": "2024-10-14T12:00:00",
    "user_id": 2,
    "end_time": "2024-10-14T12:30:00"
    },
    {
    "id": 1,
    "type": "work",
    "start_time": "2024-10-15T16:00:00",
    "user_id": 3,
    "end_time": "2024-10-15T20:00:00"
    },
  ]
  '/>
</template>

<style scoped>
header {
  line-height: 1.5;
  max-height: 100vh;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

nav {
  width: 100%;
  font-size: 12px;
  text-align: center;
  margin-top: 2rem;
}

nav a.router-link-exact-active {
  color: var(--color-text);
}

nav a.router-link-exact-active:hover {
  background-color: transparent;
}

nav a {
  display: inline-block;
  padding: 0 1rem;
  border-left: 1px solid var(--color-border);
}

nav a:first-of-type {
  border: 0;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }

  nav {
    text-align: left;
    margin-left: -1rem;
    font-size: 1rem;

    padding: 1rem 0;
    margin-top: 1rem;
  }
}
</style>
