import { createRouter, createWebHistory } from 'vue-router'
import authStore from '@/stores/auth.store.js'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', redirect: '/labs' },
    {
      path: '/labs',
      name: 'labs',
      component: () => import('@/pages/LabsPage.vue'),
      meta: { title: 'Лабораторные работы', needAuth: true },
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/pages/AuthPage.vue'),
      meta: { title: 'Авторизация', needAuth: false },
    },
    {
      path: '/labs/:id',
      name: 'LabDetails',
      component: () => import('@/pages/LabDetailsPage.vue'),
      meta: { title: 'Информация о ЛБ', needAuth: true },
    },
    {
      path: '/admin',
      name: 'AdminPanel',
      component: () => import('@/pages/AdminPage.vue'),
      meta: { title: 'Админ-панель', needAuth: true, isAdmin: true },
    },
    {
      path: '/report',
      name: 'LabReport',
      component: () => import('@/pages/LabReportPage.vue'),
      meta: { title: 'Отчет по группам', needAuth: true, isLecturer: true },
    },
    {
      path: '/profile',
      name: 'UserProfile',
      component: () => import('@/pages/UserProfilePage.vue'),
      meta: { title: 'Профиль пользователя', needAuth: true },
    },
    {
      path: '/:catchAll(.*)',
      name: 'notFound',
      component: () => import('@/pages/NotFoundPage.vue'),
      meta: { title: '404', needAuth: false },
    },
  ],
})

router.beforeEach(async (to, from, next) => {
  if (!authStore.isLoading.value) {
    await authStore.checkAuth()
  }

  if (to.name === 'login' && authStore.isAuth.value) {
    return next({ name: authStore.user.role === 'admin' ? 'AdminPanel' : 'labs' })
  }

  if (to.meta.needAuth && !authStore.isAuth.value) {
    return next({ name: 'login' })
  }

  if (to.meta.isAdmin && authStore.user.role !== 'admin') {
    return next({ name: 'labs' })
  }

  if (to.meta.isLecturer && authStore.user.role !== 'lecturer') {
    return next({ name: 'labs' })
  }

  document.title = to.meta.title
  next()
})

export default router
