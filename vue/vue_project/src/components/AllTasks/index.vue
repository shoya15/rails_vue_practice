<template>
  <div>
    <div v-for="task in tasks" :key="task.id">
      {{ task.content }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    tasks: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      content: "",
    };
  },
}
</script>
