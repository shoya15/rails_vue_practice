<template>
  <div class="header">
    <nav>
      <router-link to="/">Top</router-link>
    </nav>
    <nav>
      <div v-if="judge_user_signed_in">
        <router-link to="/create_task">タスク登録</router-link>
        <router-link to="/all_tasks">タスク一覧</router-link>
        <router-link to="/my_tasks_page">マイページ</router-link>
        <a @click="signOutButton">サインアウト</a>
      </div>
      <div v-else>
        <router-link to="/sign_up">新規登録</router-link>
        <router-link to="/sign_in">サインイン</router-link>
      </div>
    </nav>
  </div>
</template>

<script>
export default {
  methods: {
    async signOutButton() {
      await this.$store.dispatch("signOut");
    }
  },
  computed: {
    judge_user_signed_in() {
      return this.$store.state.user;
    }
  }
}
</script>

<style scoped lang="scss">
.header {
  display: flex;
  justify-content: space-between;

  nav {
    margin: 15px;
  }

  nav a {
    margin: 15px;
    text-decoration: none;
    color: #000;
    font-size: 18px;
    font-weight: bold;
    border-bottom: 2px solid transparent;
    transition: border-color .25s;
  }

  nav a:hover {
    border-bottom: 2px solid #333;
  }
}
</style>
