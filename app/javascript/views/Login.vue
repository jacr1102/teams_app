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
          this.loginUser()
        }

        e.preventDefault()
      },
      loginUser: function (){
        axios.post("/login", {user: this.user} )
          .then( (response) => {
            if(response.status === 200) {
              this.$store.commit( 'setToken', response.headers.authorization )
            }
          } )
          .catch(error => {
            this.errors = error.message;
            console.error("There was an error!", error);
          })
      }
    },
    mounted () {
      this.$store.commit('setTitle', 'Login')
      //this.$store.commit('checkAuthorization')
      /*axios
        .get('http://localhost/api/v1/users/id')
        .then( (response) => { this.data = response.data.accounts } )*/

    }
  }
</script>