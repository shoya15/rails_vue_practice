<template>
  <div>
    <TasksStatus @update_button_status="updateButtonStatus"/>
    <AllTasks
      :tasks="tasks"
      :followings="followings"
      :favorites="favorites"
      :favorites_count="favorites_count"

      @filter_tasks="filterTasksHandler"

      @follow_user="followUserHandler"
      @unfollow_user="unfollowUserHandler"

      @add_favorite_task="addFavoriteTaskHandler"
      @remove_favorite_task="removeFavoriteTaskHandler"
    />
  </div>
</template>

<script>
import AllTasks from "@/components/Task/AllTasks";
import TasksStatus from "@/components/Task/TasksStatus";

export default {
  components: {
    AllTasks,
    TasksStatus
  },
  data() {
    return {
      button_status: null,
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
      return this.$store.getters.filteredTasks({ button_status: this.button_status, filter_option: this.filter_option });
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
    // フィルタリング
    /**
     * 完了/未完了ボタンのステータスを取得するための関数
     * @param {boolean} button_status 完了/未完了ボタンのステータス
    */
    updateButtonStatus(button_status) {
      this.button_status = button_status;
    },
    
    filterTasksHandler(filter_option) {
      this.filter_option = filter_option;
    },

    // データロード
    async loadTasks() {
      await this.$store.dispatch("loadTasks");
    },
    async loadFollowings() {
      await this.$store.dispatch("loadFollowings");
    },
    async loadFavorites() {
      await this.$store.dispatch("loadFavorites");
    },
    async loadFavoritesCount() {
      await this.$store.dispatch("loadFavoritesCount");
    },

    // フォロー
    followUserHandler(task) {
      this.$store.dispatch("followUser", { user_id: task.user_id })
    },
    unfollowUserHandler(task) {
      this.$store.dispatch("unfollowUser", { user_id: task.user_id })
    },

    // いいね
    addFavoriteTaskHandler(task) {
      this.$store.dispatch("addFavoriteTask", { task_id: task.id })
    },
    removeFavoriteTaskHandler(task) {
      this.$store.dispatch("removeFavoriteTask", { task_id: task.id })
    }
  }
};
</script>
