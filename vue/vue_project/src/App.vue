<template>
  <div id="app">
    <MainHeader />
    <router-view/>
  </div>
</template>

<script>
import api from '@/api';
import MainHeader from "@/components/MainHeader";

export default {
  name: 'App',
  created() {
    this.setCSRFToken();
  },
  components: {
    MainHeader,
  },
  methods: {
    async setCSRFToken() {
      const res = await api.get('/get_csrf_token');
      api.defaults.headers.common['X-CSRF-Token'] = res.headers['x-csrf-token'];
    }
  },
}
</script>

<style lang="scss">
html, body {
  margin: 0;
  padding: 0;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>
