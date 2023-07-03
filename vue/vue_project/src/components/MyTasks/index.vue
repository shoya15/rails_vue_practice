<template>
  <div>
    <div v-for="my_task in my_tasks" :key="my_task.id">
      {{ my_task.content }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    my_tasks: {
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
