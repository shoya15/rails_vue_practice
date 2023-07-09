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
    tasks: [],
    followings: []
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
    },
    LOAD_FOLLOWINGS(state, followings) {
      state.followings = followings;
    },
    FOLLOW_USER(state, { followed_user }) {
      if(!state.followings.includes(followed_user)) state.followings.push(followed_user);
    },
    UNFOLLOW_USER(state, { unfollowed_user }) {
      const index = state.followings.findIndex((id) => id === unfollowed_user);
      state.followings.splice(index, 1);
    },
  },
  actions: {
    // ユーザー
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
        router.push({ name: 'SignInPage' });
      }
    },

    // タスク
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
    async loadTasks({ commit }) {
      if (this.state.tasks.length){
        return this.state.tasks;
      }else{
        const res = await api.get('/tasks');

        const tasks = res.data;
        if(tasks){
          commit('LOAD_TASKS', tasks);
          return tasks;
        }
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

    // フォロー
    async followUser({ commit }, { user_id }) {
      const res = await api.post('/follow', { relationship: { followed_id: user_id } });
      console.log(res.data.followed_id);
      const followed_user = res.data.followed_id;
      if(followed_user){
        commit('FOLLOW_USER', { followed_user });
        alert('フォローしました');
        return followed_user;
      }
    },
    async loadFollowings({ commit }) {
        const res = await api.get('/followings');
        const followings = res.data.followings;
        if(followings){
          commit('LOAD_FOLLOWINGS', followings);
          return followings;
        }
    },    
    async unfollowUser({ commit }, { user_id }) {
      const res = await api.delete(`/unfollow/${user_id}`);

      const unfollowed_user = res.data.user.id;
      if(unfollowed_user){
        commit('UNFOLLOW_USER', unfollowed_user);
        alert("フォロー解除しました");
        // 複数あるときにnilが原因のエラーになるため、リロードさせて情報を更新する
        location.reload();
        return unfollowed_user;
      }
    },
  },
  getters: {
    myTasks: (state) => ({ status }) => { 
      const my_tasks = state.tasks.filter((task) => task.user_id === state.user.user_id);
      if(status === null || status === false){
        return my_tasks.filter((my_task) => !my_task.status);
      }
      return my_tasks.filter((my_task) => my_task.status);
    },
    followings(state) {
      // console.log(state.followings)
      return state.followings;
    },
    filteredTasks: (state) => ({ status, filter_option }) => {
      return state.tasks
        .filter((task) => {
          if(status === null || status === false) return !task.status;
          return task.status;
        })
        .filter((task) => {
          if(!filter_option["フォローしているユーザーのタスク"] && !filter_option["いいねしたタスク"]) return state.tasks;
          if(filter_option["フォローしているユーザーのタスク"]) {
            return state.followings.includes(task.user_id);
          }
        })
        // .filter((task) => {
        //   if(filter_option[いいねしたタスク]) {
        //     return state.fights.includes(task.id)
        //   }
        // })
    }
  }
})
