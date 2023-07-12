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

// sign_up, sign_in, create_task
form{
  label, input, .button {
    cursor: pointer;
  }
  label {
    font-weight: bold;
    display: inline-block;
    margin-left: 20px;
    padding: 20px;
  }
  input {
    margin: 0 20px;
    width: 550px;
    height: 30px;
  }
  .button{
    padding: 10px;
    margin-left: 420px;
    color: #000;
    font-weight: bold;
    background-color: #fff;
    transition: .25s;
    border: 2px solid #000;
    border-radius: 5px;
  }
  .button:hover{
    color: #fff;
    background-color: #000;
  }
}

// components: AllTasks, MyTasks
.task {
  margin: 20px 40px;
  border-bottom: solid 1px #C0C0C0;
}

// components: TasksStatus, FilterTasks
.filter-option-wrap {
  margin-left: 35px;
  
  .filter-option {
    margin: 8px 10px;
  }
}
</style>
