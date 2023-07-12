<template>
  <div>
    <form>
      <div>
        <label>
          タスク内容
          <input v-model="task.content" />
        </label>
      </div>
      <button type="button" @click="createTask" class="button">登録する</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      task: {
        content: "",
      },
    };
  },
  methods: {
    createTask() {
      this.$emit("create_task", this.task);
    }
  }
}
</script>

<style scoped lang="scss">
.button{
  margin-left: 360px;
}
</style>
