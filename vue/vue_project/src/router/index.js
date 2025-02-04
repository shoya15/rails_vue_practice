import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '@/store'

import TopPage from '@/views/TopPage'
import SignUpPage from '@/views/SignUpPage'
import SignInPage from '@/views/SignInPage'
import CreateTaskPage from '@/views/CreateTaskPage'
import AllTasksPage from '@/views/AllTasksPage'
import MyTasksPage from '@/views/MyTasksPage'

Vue.use(VueRouter)
const routes = [
  {
    path: '/',
    name: 'TopPage',
    component: TopPage
  },
  {
    path: '/sign_up',
    name: 'SignUpPage',
    component: SignUpPage
  },
  {
    path: '/sign_in',
    name: 'SignInPage',
    component: SignInPage
  },
  {
    path: '/create_task',
    name: 'CreateTaskPage',
    component: CreateTaskPage
  },
  {
    path: '/all_tasks',
    name: 'AllTasksPage',
    component: AllTasksPage
  },
  {
    path: '/my_tasks_page',
    name: 'MyTasksPage',
    component: MyTasksPage
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, _, next) => {
  if(store.state.user && (to.name === "SignUpPage" || to.name === "SignInPage")){
    next({ name: "TopPage" });
  }else if(!store.state.user &&  (to.name !== "SignInPage" && to.name !== "SignUpPage" && to.name !== "TopPage")){
    next(false);
  }else{
    next();
  }
})
export default router
