<template>
  <div>

  </div>
</template>

<script>
  export default {
    components: {
    },
    mounted(){
      this.$store.commit('setTitle', 'Dashboard');
    },
    data: function () {
      return {
      }
    }
  }
</script>