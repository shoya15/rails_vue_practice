<template>
  <div>
    <MyTask
      v-for="my_task in my_tasks"
      :key="my_task.id"
      :my_task="my_task"
      @update="updateHandler"
    />
  </div>
</template>

<script>
import MyTask from "./MyTask";

export default {
  props: {
    my_tasks: {
      type: Array,
      default: () => [],
    },
  },
  components: {
    MyTask
  },
  methods: {
    updateHandler(my_task) {
      this.$emit("update", my_task);
    }
  }
}
</script>
