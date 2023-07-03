<template>
  <div>
    <MyTasks :my_tasks="my_tasks" />
  </div>
</template>

<script>
import MyTasks from "@/components/MyTasks";

export default {
  components: {
    MyTasks,
  },
  created() {
    this.myTasks();
  },
  computed: {
    my_tasks() {
      return this.$store.getters.myTasks;
    },
  },
  methods: {
    myTasks() {
      return this.$store.dispatch("loadTasksIfNeeded");
    }
  },
};
</script>
