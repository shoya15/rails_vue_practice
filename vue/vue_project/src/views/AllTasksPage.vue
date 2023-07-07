<template>
  <div>
    <TasksStatus @button_status="updateButtonStatus"/>
    <AllTasks :tasks="tasks" />
  </div>
</template>

<script>
import AllTasks from "@/components/AllTasks";
import TasksStatus from "@/components/TasksStatus";

export default {
  components: {
    AllTasks,
    TasksStatus
  },
  data() {
    return {
      status: null,
    };
  },
  created() {
    this.loadTasks();
  },
  computed: {
    tasks() {
      return this.$store.getters.allTasks({ status: this.status });
    },
  },
  methods: {
    async loadTasks() {
      await this.$store.dispatch("loadTasksIfNeeded");
    },
    updateButtonStatus(status) {
      this.status = status;
    }
  },
};
</script>
