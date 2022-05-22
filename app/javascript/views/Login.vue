<template>
  <div class="row align-items-center">
    <div class="tab-content">
      <div class="tab-pane fade show active" id="pills-login" role="tabpanel" aria-labelledby="tab-login">
        <section class="w-100 p-4 d-flex justify-content-center pb-4">
          <form class="row g-3 border py-4 px-4"
            id="login_user"
            @submit="checkUser"
            method="post">
              <p v-if="errors.length" class="text-danger fw-bold">
                <b>Validation errors:</b>
                <ul>
                  <li v-for="error in errors">{{ error }}</li>
                </ul>
              </p>

              <div class="col-md-12 text-start">
                <label for="user_email" class="form-label fw-bold">Email</label>
                <input v-model="user.email" type="email" class="form-control" name="user[email]" id="user_email" >
              </div>
              <div class="col-md-12 text-start" >
                <label for="user_password" class="form-label fw-bold">Password</label>
                <input v-model="user.password" type="password" class="form-control" name="user[password]" id="user_password" >
              </div>
              <div class="col-12 ">
                <button type="submit" class="btn btn-primary">Login</button>
              </div>
          </form>
        </section>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'NewUser',
    data: function(){
      return {
        errors: [],
        user: {
          email: null,
          password: null
        }
      }
    },
    methods: {
      checkUser: function(e){

        this.errors = []

        if (!this.user.email) {
          this.errors.push('Email is required')
        }

        if (!this.user.password  ) {
          this.errors.push('Password is required')
        }

        if (!this.errors.length) {
          this.login()
        }

        e.preventDefault()
      },
      async login (){
        try {

          const response = await this.$store.state.auth.login( this.user )

          if( response.headers.authorization ){

            localStorage.setItem('access_token', response.headers.authorization )
            localStorage.setItem('logged_user', response.data.username )

            this.$store.commit('updateAccessToken', response.headers.authorization )
            this.$store.commit('updateLoggedUser', response.data.username )

            this.$router.push("/")
          }else{
            console.log("Login Error")
          }
          console.log(response)
        } catch (error) {
          console.log(error);
        }

        /*
        axios.post( "/login", {user: this.user} )
          .then(response => {
            console.log( response )
            if(response.status === 200) {



              this.$store.commit('loginStop', null)


              this.$router.push({ path : '/'  });
            }else{
              this.errors << "Error validating login data"
            }
          })
          .catch(error => {
            console.log( error )
            this.$store.commit('loginStop', error.response.data.error)
            this.$store.commit('updateAccessToken', null)
          }) */
      }
    },
    mounted () {
      this.$store.commit('setTitle', 'Login')
    }
  }
</script>