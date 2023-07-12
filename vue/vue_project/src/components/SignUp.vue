<template>
  <form>
    <div>
      <label>
        名前
        <input class="name" v-model="user.name" />
      </label>
    </div>
    <div>
      <label>
        メールアドレス
        <input class="email" v-model="user.email" />
      </label>
    </div>
    <div>
      <label>
        パスワード
        <input :type="inputType" class="password" v-model="user.password" />
      </label>
    </div>
    <div>
      <label>
        パスワード（確認）
        <input :type="inputType" v-model="user.password_confirmation" />
      </label>
    </div>
    <div>
      <label>
        <input type="checkbox" @click="inputTypeHandler" class="input-type" />
        パスワードを表示する
      </label>
    </div>
    <button type="button" @click="createUser" class="button">登録する</button>
  </form>
</template>

<script>
export default {
  data() {
    return {
      user: {
        name: "",
        email: "",
        password: "",
        password_confirmation: "",
      },
      input_status: false
    };
  },
  methods: {
    createUser() {
      this.$emit("create_user", this.user);
    },
    inputTypeHandler() {
      this.input_status = !this.input_status;
    }
  },
  computed: {
    inputType() {
      return this.input_status ? "text" : "password";
    }
  }
}
</script>

<style scoped lang="scss">
form {
  .name {
    margin-left: 130px;
  }
  .email {
    margin-left: 50px;
  }
  .password {
    margin-left: 80px;
  }

  .input-type {
    margin-left: 180px;
    width: initial;
    height: initial;
  }
}
</style>
