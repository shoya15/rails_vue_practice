<template>
  <div>
    <div>
      <input 
        type="checkbox"
        :id="operated_task.id"
        v-model="operated_task.status"
        @change="updateHandler"
      />
      {{ my_task.content }}
    </div>
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
    updateHandler() {
      this.$emit("update", this.operated_task);
    },
  },
}
</script>
