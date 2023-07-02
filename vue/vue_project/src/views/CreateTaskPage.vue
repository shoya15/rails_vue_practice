<template>
  <CreateTask  @create_task="createTaskHandler" />
</template>

<script>
import CreateTask from "@/components/CreateTask";

export default {
  components: {
    CreateTask,
  },
  methods: {
    async createTaskHandler(task) {
      await this.$store.dispatch("createTask", {
        content: task.content
      });
    },
  },
};
</script>
