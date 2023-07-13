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
    favorites: [],
    favorites_count: null
  },
  mutations: {
    // ユーザー
    SET_USER(state, current_user) {
      state.user = current_user;
    },
    LOG_OUT_USER(state) {
      state.user = false;
    },

    // タスク
    LOAD_TASKS(state, tasks) {
      state.tasks = tasks;
    },
    ADD_TASK(state, task) {
      state.tasks.push(task);
    },
    UPDATE_TASK_STATUS(state, task) {
      const index = state.tasks.findIndex((t) => t.id === task.id);
      state.tasks.splice(index, 1, task);
    },

    // フォロー
    LOAD_FOLLOWINGS(state, followings) {
      state.followings = followings;
    },
    FOLLOW_USER(state, followed_user) {
      if(!state.followings.includes(followed_user)) state.followings.push(followed_user);
    },
    UNFOLLOW_USER(state, unfollowed_user) {
      const index = state.followings.findIndex((id) => id === unfollowed_user);
      state.followings.splice(index, 1);
    },

    // いいね
    LOAD_FAVORITES(state, favorites) {
      state.favorites = favorites;
    },
    ADD_FAVORITE_TASK(state, favorite_task) {
      if(!state.favorites.includes(favorite_task)) state.favorites.push(favorite_task);
    },
    REMOVE_FAVORITE_TASK(state, remove_favorite_task) {
      const index = state.favorites.findIndex((id) => id === remove_favorite_task);
      state.favorites.splice(index, 1);
    },
    /**
     * サインアウトするときに呼び出される関数     
     */
    RESET_FOLLOWINGS_AND_FAVORITES(state) {
      state.followings = [];
      state.favorites = [];
    },
    COUNT_FAVORITES(state, favorites_count) {
      state.favorites_count = favorites_count;
    }
  },
  actions: {
    // ユーザー
    async createUser(_, new_user) {
      const res = await api.post('/sign_up',  { user: new_user } );

      const user = res.data.user;
      if(user){
        alert('ユーザー登録が完了しました');
        router.push({ name: 'TopPage' });
      }
    },
    async signIn({ commit }, sign_in_user) {
      const res = await api.post('/sign_in', { session: sign_in_user });

      const current_user = res.data.session;
      if(current_user){
        commit('SET_USER', current_user);
        alert('サインインしました');
        router.push({ name: 'TopPage' });
      }
    },
    async signOut({ commit }) {
      const res = await api.delete('/sign_out');

      if(res.data.status){
        commit('LOG_OUT_USER');
        commit("RESET_FOLLOWINGS_AND_FAVORITES");
        alert('サインアウトしました');
        router.push({ name: 'SignInPage' });
      }
    },

    /**
     * `current_user`がnillのときに、サインインページにリダイレクトさせる関数
     */
    async checkSignedIn() {
      const res = await api.get('/check_signed_in');

      if(res.data.status){
        this.state.user = null;
        alert("サインインし直してください");
        router.push({ name: 'SignInPage' });
      }
    },

    // タスク
    async loadTasks({ commit }) {
      if(this.state.tasks.length) return this.state.tasks;
      const res = await api.get('/tasks');
      const tasks = res.data.tasks;
      if(tasks){
        commit('LOAD_TASKS', tasks);
        return tasks;
      }
    },
    async createTask({ commit }, new_task) {
      const res = await api.post('/tasks', { task: new_task });
      const task = res.data.task;
      if(task){
        commit('ADD_TASK', task);
        alert('タスクを追加しました');
        router.push({ name: 'AllTasksPage' });
        return task;
      }
    },
    async updateTaskStatus({ commit }, task) {
      const res = await api.put(`/tasks/${task.id}`, task);

      const operated_task = res.data.task;
      if(operated_task){
        commit('UPDATE_TASK_STATUS', operated_task);
        return operated_task;
      }
    },

    // フォロー
    async loadFollowings({ commit }) {
      if(this.state.followings.length) return this.state.followings;
      const res = await api.get('/followings');
      const followings = res.data.followings;
      if(followings){
        commit('LOAD_FOLLOWINGS', followings);
        return followings;
      }
    },    
    async followUser({ commit }, { user_id }) {
      const res = await api.post('/follow', { relationship: { followed_id: user_id } });
      const followed_user = res.data.followed_id;
      if(followed_user){
        commit('FOLLOW_USER', followed_user);
        alert('フォローしました');
        return followed_user;
      }
    },
    async unfollowUser({ commit }, { user_id }) {
      const res = await api.delete(`/unfollow/${user_id}`);

      const unfollowed_user = res.data.user.followed_id;
      if(unfollowed_user){
        commit('UNFOLLOW_USER', unfollowed_user);
        alert("フォロー解除しました");
        location.reload();
        return unfollowed_user;
      }
    },

    // いいね
    async loadFavorites({ commit }) {
      if(this.state.favorites.length) return this.state.favorites;
      const res = await api.get('/favorites');
      const favorites = res.data.favorites;
      if(favorites){
        commit('LOAD_FAVORITES', favorites);
        return favorites;
      }
    },
    async addFavoriteTask({ commit }, { task_id }) {
      const res = await api.post('/favorites', { task_id: task_id });
      const favorite_task = res.data.favorite_task.task_id;
      if(favorite_task){
        commit('ADD_FAVORITE_TASK', favorite_task);
        alert('いいねしました！');
        location.reload();
        return favorite_task;
      }
    },
    async removeFavoriteTask({ commit }, { task_id }) {
      const res = await api.delete(`/favorites/${task_id}`);
      const remove_favorite_task = res.data.task.task_id;
      if(remove_favorite_task){
        commit('REMOVE_FAVORITE_TASK', remove_favorite_task);
        alert("いいねを外しました");
        location.reload();
        return remove_favorite_task;
      }
    },
    /**
     * いいね数を読み込むための関数
     * @return いいね数を返す
     */
    async loadFavoritesCount({ commit }) {
      const res = await api.get('/favorites_count');

      const favorites_count = res.data.favorites_count;
      if(favorites_count){
        commit('COUNT_FAVORITES', favorites_count);
        return favorites_count;
      }
    }
  },
  getters: {
    /**
     * タスクをフィルタリングするための関数
     * @param {boolean} button_status 完了/未完了ボタンのステータス
     * @param {Object} filter_option フィルタリングの条件
     * @returns {Object} フィルタリング後のタスクを返す
     */
    filteredTasks: (state) => ({ button_status, filter_option }) => {
      return state.tasks
        .filter((task) => {
          if(filter_option["my_task"]) return task.user_id === state.user.user_id;
          return state.tasks;
        })
        .filter((task) => {
          if(button_status === null || button_status === false) return !task.status;
          return task.status;
        })
        .filter((task) => {
          const filter_following_tasks = filter_option["フォローしているユーザーのタスク"];
          const filter_favorite_tasks  = filter_option["いいねしたタスク"];

          const following_tasks = state.followings.includes(task.user_id);
          const favorite_tasks  = state.favorites.includes(task.id);
          
          if(filter_following_tasks){
            return filter_favorite_tasks ? (following_tasks && favorite_tasks) : following_tasks;
          }else if(filter_favorite_tasks){
            return favorite_tasks
          }else{
            return state.tasks;
          }
        })
    },

    followings(state) {
      return state.followings;
    },
    favorites(state) {
      return state.favorites;
    },
    favorites_count(state) {
      return state.favorites_count;
    }
  }
})
