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
    createUserHandler(user) {
      this.$store.dispatch("createUser", user);
    }
  }
}
</script>
