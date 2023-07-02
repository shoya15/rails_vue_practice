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
  },
  mutations: {
    SET_USER(state, { user }) {
      state.user = user;
    },
    LOG_OUT_USER(state) {
      state.user = false;
    },
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
    }
  },
  getters: {
  }
})
