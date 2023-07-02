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
        <input type="password" class="password" v-model="user.password" />
      </label>
    </div>
    <div>
      <label>
        パスワード（確認）
        <input type="password" v-model="user.password_confirmation" />
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
    };
  },
  methods: {
    createUser() {
      this.$emit("create", this.user);
    },
  },
}
</script>

<style scoped lang="scss">
form {
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
    margin: 20px;
    width: 550px;
    height: 30px;
  }

  .name {
    margin-left: 130px;
  }
  .email {
    margin-left: 50px;
  }
  .password {
    margin-left: 80px;
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
</style>
