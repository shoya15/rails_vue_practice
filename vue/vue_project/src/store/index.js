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
    followings: [],
    favorites: []
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
    LOAD_FAVORITES(state, favorites) {
      state.favorites = favorites;
    },
    ADD_FAVORITE_TASK(state, { favorite_task }) {
      if(!state.favorites.includes(favorite_task)) state.favorites.push(favorite_task);
    },
    REMOVE_FAVORITE_TASK(state, { favorite_task }) {
      const index = state.favorites.findIndex((id) => id === favorite_task);
      state.favorites.splice(index, 1);
    }
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
    async updateTask({ commit }, task) {
      const res = await api.put(`/tasks/${task.my_task.id}`, task.my_task);

      const checked_task = res.data.task;
      if(checked_task){
        commit('UPDATE_TASK', checked_task);
        return checked_task;
      }
    },

    // フォロー
    async followUser({ commit }, { user_id }) {
      const res = await api.post('/follow', { relationship: { followed_id: user_id } });
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

    // ファイト(いいね)
    async addFavoriteTask({ commit }, { task_id }) {
      const res = await api.post('/favorites', { task_id: task_id });
      const favorite_task = res.data;
      if(favorite_task){
        commit('ADD_FAVORITE_TASK', { favorite_task });
        alert('いいねしました！');
        location.reload();
        return favorite_task;
      }
    },
    async loadFavorites({ commit }) {
      const res = await api.get('/favorites');
      const favorites = res.data.favorites;
      if(favorites){
        commit('LOAD_FAVORITES', favorites);
        return favorites;
      }
    },    
    async removeFavoriteTask({ commit }, { task_id }) {
      const res = await api.delete(`/favorites/${task_id}`);

      const remove_favorite_task = res.data.task.id;
      if(remove_favorite_task){
        commit('REMOVE_FAVORITE_TASK', remove_favorite_task);
        alert("いいねを外しました");
        location.reload();
        return remove_favorite_task;
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
      console.log(state.tasks)
      console.log(state.favorites)
      return state.tasks
        .filter((task) => {
          if(status === null || status === false) return !task.status;
          return task.status;
        })
        .filter((task) => {
          if(!filter_option["フォローしているユーザーのタスク"] && !filter_option["いいねしたタスク"]) return state.tasks;
          if(filter_option["フォローしているユーザーのタスク"]) {
            if(filter_option["いいねしたタスク"]) return state.followings.includes(task.user_id) && state.favorites.includes(task.id);
            return state.followings.includes(task.user_id)
          }
          if(filter_option["いいねしたタスク"]) return state.favorites.includes(task.id);
        })
    },
    favorites(state) {
      return state.favorites;
    },
  }
})
