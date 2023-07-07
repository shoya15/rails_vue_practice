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
        <input class="password" v-model="user.password" />
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
    };
  },
  methods: {
    signIn() {
      this.$emit("sign_in", this.user);
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
    margin-left: 20px;
    width: 550px;
    height: 30px;
  }

  .password {
    margin-left: 130px;
  }
  .button{
    padding: 10px;
    margin-top: 20px;
    margin-left: 450px;
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
