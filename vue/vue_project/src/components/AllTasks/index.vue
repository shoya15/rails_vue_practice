<template>
  <div>
    <FilterTasks @filter_tasks="filterTasks"/>
    <div v-for="task in tasks" :key="task.id">
      <div class="task">
        {{ task.content }}
        ← created by {{ task.user_name }}
        
        <span v-if="isOwnerUser(task.user_id) && favoriteTasks(task.id)">
          <button type="button" class="favorite" @click="addFavoriteTask(task)">♡</button>
        </span>
        <span v-else-if="isOwnerUser(task.user_id)">
          <button type="button" class="favorite" @click="removeFavoriteTask(task)">❤️</button>
        </span>

        <span v-if="isOwnerUser(task.user_id) && followedUser(task.user_id)">
          <button type="button" class="follow-button" @click="followUser(task)">フォロー</button>
        </span>
        <span v-else-if="isOwnerUser(task.user_id)">
          <button type="button" class="unfollow-button" @click="unfollowUser(task)">フォロー解除</button>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
import FilterTasks from "./FilterTasks";

export default {
  components: {
    FilterTasks
  },
  props: {
    tasks: {
      type: Array,
      default: () => [],
    },
    followings: {
      type: Array,
      default: () => [],
    },
    favorites: {
      type: Array,
      default: () => [],
    }
  },
  methods: {
    isOwnerUser(user_id) {
      return this.$store.state.user.user_id !== user_id
    },
    followedUser(user_id) {
      return !this.followings.includes(user_id);
    },
    followUser(task) {
      this.$emit("follow_user", task);
    },
    unfollowUser(task) {
      this.$emit("unfollow_user", task);
    },
    filterTasks(filter_option) {
      this.$emit("filter_tasks", filter_option)
    },
    favoriteTasks(task_id) {
      return !this.favorites.includes(task_id);
    },
    addFavoriteTask(task) {
      this.$emit("add_favorite_task", task);
    },
    removeFavoriteTask(task) {
      this.$emit("remove_favorite_task", task);
    }
  }
}
</script>

<style scoped lang="scss">
.task {
  margin: 20px;
  border-bottom: solid 1px #C0C0C0;

  .favorite {
    background-color: #FFF;
    border: #FFF;
  }
  .follow-button, .unfollow-button{
    margin-bottom: 10px;
    color: #000;
    background-color: #fff;
    transition: .25s;
    border: 1px solid #333;
    border-radius: 5px;
  }
  
  .follow-button:hover{
      color: #fff;
      background-color: blue;
      border: 1px solid blue;
  }
  .unfollow-button:hover{
      color: #fff;
      background-color: red;
      border: 2px solid red;
  }
}
</style>
