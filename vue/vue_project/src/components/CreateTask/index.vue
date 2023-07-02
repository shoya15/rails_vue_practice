<template>
  <div>
    <div>
      <label>
        タスク内容
        <input v-model="task.content" />
      </label>
    </div>
    <button type="button" @click="createTask" class="button">登録する</button>
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
    },
  },
}
</script>

<style scoped lang="scss">
label, input, .button {
  cursor: pointer;
}

label {
  font-weight: bold;
  display: inline-block;
  margin-left: 20px;
  padding: 20px;
}

input {
  margin: 20px;
  width: 550px;
  height: 30px;
}
.button{
  padding: 10px;
  margin-left: 360px;
  color: #000;
  font-weight: bold;
  background-color: #fff;
  transition: .25s;
  border: 2px solid #000;
  border-radius: 5px;
}

.button:hover{
    color: #fff;
    background-color: #000;
}
</style>
