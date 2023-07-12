<template>
  <div>
  </div>
</template>

<script>

export default {
  created() {
    this.checkSignedIn();
  },
  methods: {
    checkSignedIn(){
      this.$store.dispatch("checkSignedIn");
    }
  }
}
</script>
