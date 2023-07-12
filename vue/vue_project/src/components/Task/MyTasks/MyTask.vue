<template>
  <div>
    <input 
      type="checkbox"
      :id="operated_task.id"
      v-model="operated_task.status"
      @change="updateTaskStatus"
    />
    {{ my_task.content }}
  </div>
</template>

<script>
export default {
  props: {
    my_task: {
      type: Object,
      default: () => {},
    },
  },
  created() {
    this.operated_task = this.my_task;
  },
  data() {
    return {
      operated_task: null,
    };
  },
  methods: {
    updateTaskStatus() {
      this.$emit("update_task_status", this.operated_task);
    }
  }
}
</script>

<style scoped lang="scss">
input {
  cursor: pointer;
}
</style>
