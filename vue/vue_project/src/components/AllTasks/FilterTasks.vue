<template>
  <div>
    <span v-for="filter_option in Object.keys(FILTER)" :key="filter_option">
      <input type="checkbox" :id="filter_option" @change="filterTasks(filter_option)" />
      <label :for="filter_option">{{ filter_option }}</label>
    </span>
  </div>
</template>

<script>
export default {
  computed: {
    FILTER() {
      return {
        フォローしているユーザーのタスク: false,
        いいねしたタスク: false
      }
    }
  },
  methods: {
    filterTasks(filter_option) {
      this.FILTER[filter_option] = !this.FILTER[filter_option]
      this.$emit("filter_tasks", this.FILTER);
    }
  }
};
</script>
