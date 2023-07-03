<template>
  <div>
    <AllTasks :tasks="tasks" />
  </div>
</template>

<script>
import AllTasks from "@/components/AllTasks";

export default {
  components: {
    AllTasks,
  },
  created() {
    this.loadTasks();
  },
  computed: {
    tasks() {
      return this.$store.getters.allTasks;
    },
  },
  methods: {
    loadTasks() {
      return this.$store.dispatch("loadTasksIfNeeded");
    }
  },
};
</script>
