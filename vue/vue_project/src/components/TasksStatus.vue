<template>
  <div class="status flex-item">
    <span v-for="status in Object.keys(STATUSES)" :key="status">
      <input type="radio" :id="status" v-model="selectedStatus" :value="status" @click="updateStatusButton" />
      <label :for="status">{{ status }}</label>
    </span>
  </div>
</template>

<script>
export default {
  data() {
    return {
      selectedStatus: "未完了",
    };
  },
  computed: {
    STATUSES() {
      return {
        完了済み: true,
        未完了: null
      };
    }
  },
  methods: {
    updateStatusButton() {
      this.$emit("button_status", !this.STATUSES[this.selectedStatus]);
    }
  }
};
</script>
