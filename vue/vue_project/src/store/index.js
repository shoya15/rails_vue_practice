import Vue from 'vue'
import Vuex from 'vuex'
import api from '@/api'
import router from '@/router'
import createPersistedState from "vuex-persistedstate"; 

Vue.use(Vuex)

export default new Vuex.Store({
  plugins: [createPersistedState()],
  state: {
    user: false,
    tasks: []
  },
  mutations: {
    SET_USER(state, { user }) {
      state.user = user;
    },
    LOG_OUT_USER(state) {
      state.user = false;
    },
    ADD_TASK(state, { task }) {
      state.tasks.push(task);
    },
    LOAD_TASKS(state, tasks) {
      state.tasks = tasks;
    },
    UPDATE_TASK(state, task) {
      const index = state.tasks.findIndex((t) => t.id === task.id);
      state.tasks.splice(index, 1, task);
    }
  },
  actions: {
    async createUser({ commit }, { name, email, password, password_confirmation }) {
      const res = await api.post('/sign_up', { user: {
        name: name,
        email: email,
        password: password,
        password_confirmation: password_confirmation
      }});

      const user = res.data.user;
      if(user){
        alert('ユーザー登録が完了しました');
        router.push({ name: 'TopPage' });
      }
    },
    async signIn({ commit }, { name_or_email, password }) {
      const res = await api.post('/sign_in', { session: {
        name_or_email: name_or_email,
        password: password
      }});

      const user = res.data.session;
      if(user){
        commit('SET_USER', { user });
        alert('サインインしました');
        router.push({ name: 'TopPage' });
      }
    },
    async signOut({ commit }) {
      const res = await api.delete('/sign_out');

      if(!res.data){
        commit('LOG_OUT_USER');
        alert('サインアウトしました');
      }
    },
    async createTask({ commit }, { content }) {
      const res = await api.post('/tasks', { task: { content: content }});

      const task = res.data.task;
      if(task){
        commit('ADD_TASK', { task });
        alert('タスクを追加しました');
        router.push({ name: 'TopPage' });
        return task;
      }
    },
    async loadTasksIfNeeded({ commit }) {
      if (this.state.tasks.length) return this.state.tasks;
      const res = await api.get('/tasks');

      const tasks = res.data;
      if(tasks){
        commit('LOAD_TASKS', tasks);
        return tasks;
      }
    },
    async updateTask({ commit }, { task }) {
      const res = await api.put(`/tasks/${task.id}`, task);

      const checked_task = res.data.task;
      if(checked_task){
        commit('UPDATE_TASK', checked_task);
        return checked_task;
      }
    },
  },
  getters: {
    allTasks: (state) => ({ status }) => {
      if(status === null || status === false){
        return state.tasks.filter((task) => !task.status);
      }
      return state.tasks.filter((task) => task.status);
    },
    myTasks: (state) => ({ status }) =>{ 
      const my_tasks = state.tasks.filter((task) => task.user_id === state.user.user_id);
      if(status === null || status === false){
        return my_tasks.filter((my_task) => !my_task.status);
      }
      return my_tasks.filter((my_task) => my_task.status);
    }
  }
})
