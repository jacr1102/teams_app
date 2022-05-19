<template>
  <div class="container text-center mt-5">
    <div class="row">
      <div class="col-md-12">
        <div id="app">
          <div id="nav">
            <router-link to="/">Home</router-link>
            <router-link to="/users">Users</router-link>
          </div>
          <h1>{{title}}</h1>
          <router-view/>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

  export default {
    components: {

    },
    computed: {
      title(){
        return this.$store.state.title
      }
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