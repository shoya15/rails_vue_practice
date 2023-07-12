<template>
  <div>
    <MyTask
      v-for="my_task in my_tasks"
      class="task"
      :key="my_task.id"
      :my_task="my_task"
      @update_task_status="updateTaskStatusHandler"
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
    updateTaskStatusHandler(operated_task) {
      this.$emit("update_task_status", operated_task);
    }
  }
}
</script>
