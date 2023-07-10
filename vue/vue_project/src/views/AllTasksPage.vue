<template>
  <div>
    <TasksStatus @button_status="updateButtonStatus"/>
    <AllTasks
      :tasks="tasks"
      :followings="followings"
      :favorites="favorites"
      :favorites_count="favorites_count"
      @follow_user="followUser"
      @unfollow_user="unfollowUser"
      @filter_tasks="filterTasks"
      @add_favorite_task="addFavoriteTask"
      @remove_favorite_task="removeFavoriteTask"
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
    this.loadFavorites();
    this.loadFavoritesCount();
  },
  computed: {
    tasks() {
      return this.$store.getters.filteredTasks({ status: this.status, filter_option: this.filter_option });
    },
    followings() {
      return this.$store.getters.followings;
    },
    favorites() {
      return this.$store.getters.favorites;
    },
    favorites_count() {
      return this.$store.getters.favorites_count;
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
    },
    async loadFavorites() {
      await this.$store.dispatch("loadFavorites");
    },
    addFavoriteTask(task) {
      this.$store.dispatch("addFavoriteTask", { task_id: task.id })
    },
    removeFavoriteTask(task) {
      this.$store.dispatch("removeFavoriteTask", { task_id: task.id })
    },
    async loadFavoritesCount() {
      await this.$store.dispatch("loadFavoritesCount");
    },
  }
};
</script>
