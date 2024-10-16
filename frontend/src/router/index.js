import { createRouter, createWebHistory } from 'vue-router'
import UserDashboardView from '../views/UserDashboardView.vue'
import HomeView from '@/views/HomeView.vue'
import UserSettingsView from '@/views/UserSettingsView.vue'
import DayOffView from '@/views/DayOffView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/dashboardUser',
      name: 'dashboardUser',
      component: UserDashboardView
    },
    {
      path: '/modifyUser',
      name: 'modifyUser',
      component: UserSettingsView
    },
    {
      path: '/requestDayOff',
      name: 'requestDayOff',
      component: DayOffView
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
