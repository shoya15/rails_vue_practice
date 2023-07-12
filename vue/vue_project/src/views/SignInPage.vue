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
    signInHandler(user) {
      this.$store.dispatch("signIn", user);
    }
  }
}
</script>
