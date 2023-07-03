<template>
  <SignUp @create_user="createUserHandler" />
</template>

<script>
import SignUp from "@/components/SignUp";

export default {
  components: {
    SignUp
  },
  methods: {
    async createUserHandler(user) {
      await this.$store.dispatch("createUser", {
        name: user.name,
        email: user.email,
        password: user.password,
        password_confirmation: user.password_confirmation
      });
    }
  }
}
</script>
