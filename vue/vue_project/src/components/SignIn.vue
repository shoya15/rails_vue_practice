<template>
  <form>
    <div>
      <label>
        名前またはメールアドレス
        <input v-model="user.name_or_email" />
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
        <input type="checkbox" @click="inputTypeHandler" class="input-type" />
        パスワードを表示する
      </label>
    </div>
    <button type="button" @click="signIn" class="button" >サインインする</button>
  </form>
</template>

<script>
export default {
  data() {
    return {
      user: {
        name_or_email: "",
        password: ""
      },
      input_status: false
    };
  },
  methods: {
    signIn() {
      this.$emit("sign_in", this.user);
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
  .password {
    margin-left: 130px;
  }

  .input-type {
    margin-left: 220px;
    width: initial;
    height: initial;
  }
  .button{
    margin-top: 20px;
    margin-left: 450px;
  }
}
</style>
