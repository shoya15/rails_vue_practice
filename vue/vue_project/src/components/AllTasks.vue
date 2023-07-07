<template>
  <div>
    <div v-for="task in tasks" :key="task.id" @update="updateHandler">
      {{ task.content }}
      ← created by user:
      {{ task.user_id }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    tasks: {
      type: Array,
      default: () => [],
    }
  },
  methods: {
    updateHandler(task) {
      this.$emit("update", task);
    }
  }
}
</script>
