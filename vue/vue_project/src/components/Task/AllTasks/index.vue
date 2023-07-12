<template>
  <div>
    <FilterTasks @filter_tasks="filterTasksHandler"/>
    <div v-for="task in tasks" :key="task.id">
      <div class="task">
        {{ task.content }}
        ← created by {{ task.user_name }}
        
        <span v-if="!isOwnerUser(task.user_id)">
          <span v-if="!favoriteTasks(task.id)">
            <button type="button" class="favorite" @click="addFavoriteTask(task)">♡</button>
            {{ favorites_count[task.id] }}
          </span>
          <span v-else>
            <button type="button" class="favorite" @click="removeFavoriteTask(task)">❤️</button>
            {{ favorites_count[task.id] }}
          </span>

          <span v-if="!followedUser(task.user_id)">
            <button type="button" class="follow-button" @click="followUser(task)">フォロー</button>
          </span>
          <span v-else>
            <button type="button" class="unfollow-button" @click="unfollowUser(task)">フォロー解除</button>
          </span>
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
    },
    favorites_count: {
      type: Object,
      default: () => {},
    }
  },
  methods: {
    // フィルタリング
    filterTasksHandler(filter_option) {
      this.$emit("filter_tasks", filter_option)
    },

    /**
     * タスクの作成者かどうかを確かめる関数
     * @param {integer} user_id タスクの作成者
     * @return {boolean} タスクの作成者であるかどうかを返す
    */
    isOwnerUser(user_id) {
      return this.$store.state.user.user_id === user_id
    },

    /**
     * フォローしているユーザーかどうかを確かめる関数
     * @param {integer} user_id タスクの作成者
     * @return {boolean} フォローしているかどうかを返す
    */
    followedUser(user_id) {
      return this.followings.includes(user_id);
    },

    /**
     * いいねしたタスクかどうかを確かめる関数
     * @param {integer} task_id タスクのID
     * @return {boolean} いいねしているかどうかを返す
    */
    favoriteTasks(task_id) {
      return this.favorites.includes(task_id);
    },

    // フォロー
    followUser(task) {
      this.$emit("follow_user", task);
    },
    unfollowUser(task) {
      this.$emit("unfollow_user", task);
    },

    // いいね
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
