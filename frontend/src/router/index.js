import { createRouter, createWebHistory } from 'vue-router'
import UserDashboardView from '../views/UserDashboardView.vue'
import HomeView from '@/views/HomeView.vue'
import UserSettingsView from '@/views/UserSettingsView.vue'
import DayOffView from '@/views/DayOffView.vue'
import ManagerDashboardView from '@/views/ManagerDashboardView.vue'
import ManageTeamView from '@/views/ManageTeamView.vue'
import AddTeamMemberView from '@/views/AddTeamMemberView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/user/dashboard',
      name: 'dashboardUser',
      component: UserDashboardView
    },
    {
      path: '/user/modify',
      name: 'modifyUser',
      component: UserSettingsView
    },
    {
      path: '/user/requestDayOff',
      name: 'requestDayOff',
      component: DayOffView
    },
    {
      path: '/manager/dashboard',
      name: 'dashboardManager',
      component: ManagerDashboardView
    },
    ,
    {
      path: '/team/manage',
      name: 'manageTeam',
      component: ManageTeamView
    },
    {
      path: '/team/addUser',
      name: 'addUserToTeam',
      component: AddTeamMemberView
    },
    {
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue')
    }
  ]
})

export default router
