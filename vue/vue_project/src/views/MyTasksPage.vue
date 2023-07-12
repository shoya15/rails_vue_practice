<template>
  <div>
    <TasksStatus @update_button_status="updateButtonStatus"/>
    <MyTasks :my_tasks="my_tasks" @update_task_status="updateTaskStatusHandler" />
  </div>
</template>

<script>
import MyTasks from "@/components/Task/MyTasks";
import TasksStatus from "@/components/Task/TasksStatus";

export default {
  components: {
    MyTasks,
    TasksStatus
  },
  data() {
    return {
      button_status: null,
    };
  },
  created() {
    this.loadTasks();
  },
  computed: {
    my_tasks() {
      return this.$store.getters.filteredTasks({ button_status: this.button_status, filter_option: { "my_task": true } });
    },
  },
  methods: {
    async loadTasks() {
      await this.$store.dispatch("loadTasks");
    },
    /**
     * 完了/未完了ボタンのステータスを取得するための関数
     * @param {boolean} button_status 完了/未完了ボタンのステータス
    */
    updateButtonStatus(button_status) {
      this.button_status = button_status;
    },
    
    updateTaskStatusHandler(operated_task) {
      this.$store.dispatch("updateTaskStatus", operated_task);
    }
  }
};
</script>
