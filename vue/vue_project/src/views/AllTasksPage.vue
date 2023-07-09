<template>
  <div>
    <TasksStatus @button_status="updateButtonStatus"/>
    <AllTasks
      :tasks="tasks"
      :followings="followings"
      @follow_user="followUser"
      @unfollow_user="unfollowUser"
      @filter_tasks="filterTasks"
    />
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
      filter_option: {}
    };
  },
  created() {
    this.loadTasks();
    this.loadFollowings();
  },
  computed: {
    tasks() {
      return this.$store.getters.filteredTasks({ status: this.status, filter_option: this.filter_option });
    },
    followings() {
      return this.$store.getters.followings;
    }
  },
  methods: {
    async loadTasks() {
      await this.$store.dispatch("loadTasks");
    },
    updateButtonStatus(status) {
      this.status = status;
    },
    async loadFollowings() {
      await this.$store.dispatch("loadFollowings");
    },
    followUser(task) {
      this.$store.dispatch("followUser", { user_id: task.user_id })
    },
    unfollowUser(task) {
      this.$store.dispatch("unfollowUser", { user_id: task.user_id })
    },
    filterTasks(filter_option) {
      this.filter_option = filter_option;
    }
  }
};
</script>
