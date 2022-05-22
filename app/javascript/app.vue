<template>
  <div class="container text-center mt-5">
    <div class="row">
      <div class="col-md-12">
        <div id="app">
          <nav v-if="this.$store.state.logged_in" id="nav" class="navbar navbar-dark bg-primary navbar-expand-lg">
            <div class="container-fluid">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item">
                    <router-link class="nav-link" to="/">Home</router-link>
                  </li>
                  <li class="nav-item">
                    <router-link class="nav-link" to="/users">Users</router-link>
                  </li>
                  <li class="nav-item">
                    <router-link class="nav-link" to="/accounts">Accounts</router-link>
                  </li>
                  <li class="nav-item">
                    <router-link class="nav-link" to="/accounts">User Logs</router-link>
                  </li>
                  <li class="nav-item">
                    <a href="#" class="nav-link" @click="logout">Logout</a>
                  </li>
                </ul>
                <div>
                  <p class="btn-circle">{{this.$store.state.username}}</p>
                </div>
            </div>
          </nav>
          <div class="container py-5">
            <h1>{{title}}</h1>
            <div class="container pt-5">
              <router-view/>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
  .btn-circle {
    padding: 0px 20px;
    border-radius: 15px;
    text-align: center;
    font-size: 12px;
    line-height: 27px;
    background: white;
    color: blue;
    font-weight: bold;

}
</style>
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
      //this.$store.commit('setTitle', 'Dashboard');
    },
    data: function () {
      return {

      }
    },
    methods: {
      logout({ commit }){
        localStorage.removeItem('logged_user')
        localStorage.removeItem('access_token')

        this.$store.commit('updateAccessToken', null);
        this.$store.commit('updateLoggedUser', null);

        this.$router.push('/login')

      }
    },
    beforeCreate () {
      this.$store.dispatch('fetchAccessToken')
      if( !this.$store.state.logged_in && this.$route.path != '/login'){
        this.$router.push('/login')
      }
    }
  }
</script>