<template>
  <CreateTask  @create_task="createTaskHandler" />
</template>

<script>
import CreateTask from "@/components/Task/CreateTask";

export default {
  components: {
    CreateTask,
  },
  methods: {
    createTaskHandler(task) {
      this.$store.dispatch("createTask", task);
    }
  }
};
</script>
