<template>
  <div>
    <TasksStatus @button_status="updateButtonStatus"/>
    <MyTasks :my_tasks="my_tasks" @update="updateHandler" />
  </div>
</template>

<script>
import MyTasks from "@/components/MyTasks";
import TasksStatus from "@/components/TasksStatus";

export default {
  components: {
    MyTasks,
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
    my_tasks() {
      return this.$store.getters.myTasks({ status: this.status });
    },
  },
  methods: {
    async loadTasks() {
      await this.$store.dispatch("loadTasks");
    },
    updateButtonStatus(status) {
      this.status = status;
    },
    updateHandler(my_task) {
      this.$store.dispatch("updateTask", {my_task});
    }
  },
};
</script>
