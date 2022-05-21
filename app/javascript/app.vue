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
                  <!--<li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                      Dropdown
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                      <li><a class="dropdown-item" href="#">Action</a></li>
                      <li><a class="dropdown-item" href="#">Another action</a></li>
                      <li><hr class="dropdown-divider"></li>
                      <li><a class="dropdown-item" href="#">Something else here</a></li>
                    </ul>
                  </li> -->
                </ul>
            </div>
          </nav>
          <div class="container py-5">
            <h1>{{title}}</h1>
            <h1>{{ this.$store.state.logged_user.names }}</h1>
            <h1>{{ this.$store.state.logged_user.email }}</h1>
            <div class="container pt-5">
              <router-view/>
            </div>
          </div>
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
      //this.$store.commit('setTitle', 'Dashboard');
    },
    data: function () {
      return {

      }
    },
    beforeCreate () {
      this.$store.dispatch('fetchAccessToken')

      if ( !this.$store.state.logged_in && this.$route.name != 'login') {
        this.$router.push({ path: '/login' })
      }

      if(this.$store.state.logged_in){
        this.$router.push({ path: '/' })
      }
    }
  }
</script>