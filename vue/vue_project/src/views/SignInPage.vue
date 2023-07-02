<template>
  <SignIn @sign_in="signInHandler" />
</template>

<script>
import SignIn from "@/components/SignIn";

export default {
  components: {
    SignIn
  },
  methods: {
    async signInHandler(user) {
      await this.$store.dispatch("signIn", {
        name_or_email: user.name_or_email,
        password: user.password
      });
    }
  }
}
</script>
