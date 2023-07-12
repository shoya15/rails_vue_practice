<template>
  <div class="filter-option-wrap">
    <span v-for="status in Object.keys(STATUSES)" :key="status">
      <input 
        type="radio"
        class="filter-option"
        :id="status"
        v-model="selectedStatus"
        :value="status"
        @click="updateButtonStatus"
      />
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
    updateButtonStatus() {
      this.$emit("update_button_status", !this.STATUSES[this.selectedStatus]);
    }
  }
};
</script>
