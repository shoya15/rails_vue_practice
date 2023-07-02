import Vue from 'vue'
import Vuex from 'vuex'
import api from '@/api'
import router from '@/router'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    user: {},
  },
  mutations: {
    CREATE_USER(state, { user }) {
      state.user = user;
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
      alert('ユーザー登録が完了しました');

      const user = res.data.user;
      if(user){
        router.push({ name: 'TopPage' });
      }
    }
  },
  getters: {
  }
})
