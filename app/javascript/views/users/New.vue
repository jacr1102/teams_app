<template>
  <div>
    <div class="border container px-4 py-4">
      <form class="row g-3"
        id="create_user"
        @submit="checkForm"
        method="post">
          <p v-if="errors.length" class="text-danger fw-bold">
            <b>Validation errors:</b>
            <ul>
              <li v-for="error in errors">{{ error }}</li>
            </ul>
          </p>

          <div class="col-md-6 text-start">
            <label for="user_first_name" class="form-label fw-bold">First Name</label>
            <input v-model="user.first_name" type="text" class="form-control" name="user[first_name]" id="user_first_name" >
          </div>
          <div class="col-md-6 text-start" >
            <label for="user_last_name" class="form-label fw-bold">Last Name</label>
            <input v-model="user.last_name" type="text" class="form-control" name="user[last_name]" id="user_last_name" >
          </div>
          <div class="col-md-6 text-start">
            <label for="user_usename" class="form-label fw-bold">Username</label>
            <input v-model="user.username" type="text" class="form-control" name="user[username]" id="user_username">
          </div>
          <div class="col-md-6 text-start">
            <label for="user_email" class="form-label fw-bold">Email</label>
            <input v-model="user.email" type="email" class="form-control" name="user[email]" id="user_email">
          </div>
          <div v-if="!user.id" class="col-md-6 text-start">
            <label for="user_password" class="form-label fw-bold">Password</label>
            <input v-model="user.password" type="password" class="form-control" name="user[password]" id="user_password">
          </div>
          <div v-if="!user.id" class="col-md-6 text-start">
            <label for="confirm_password" class="form-label fw-bold">Confirm Password</label>
            <input v-model="confirm_password" type="password" class="form-control" name="confirm_password" id="confirm_password">
          </div>
          <div class="col-6 text-start">
            <label  for="user_profile_english_level" class="form-label fw-bold">English Level</label>
            <select v-model="user.profile_attributes.english_level" class="form-select" id="user_profile_english_level" name="user[profile][english_level]" >
              <option v-for="level in english_levels" :value="level.id">{{level.name}}</option>
            </select>
          </div>
          <div class="col-6 text-start">
            <label  for="user_role" class="form-label fw-bold">Role</label>
            <select v-model="user.role_id" class="form-select" id="user_role" name="user[role]" >
              <option v-for="role in roles" :value="role.id">{{role.name}}</option>
            </select>
          </div>
          <div class="col-12 text-start">
            <label for="user_profile_cv_link" class="form-label fw-bold">CV Link</label>
            <input v-model="user.profile_attributes.cv_link" type="text" class="form-control" id="user_profile_cv_link" name="user[profile][cv_link]" >
          </div>
          <div class="col-md-12 text-start">
            <label for="user_profile_technical_experience" class="form-label fw-bold">Technical Experience</label>
            <textarea v-model="user.profile_attributes.technical_experience" type="text" class="form-control" id="user_profile_technical_experience" name="user[profile][technical_experience]" ></textarea>
          </div>
          <div class="col-12 ">
            <button type="submit" class="btn btn-primary">{{form_action}} User</button>
          </div>
      </form>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'NewUser',
    data: function(){
      return {
        errors: [],
        confirm_password: null,
        form_action: 'Create',
        roles: [],
        user: {
          id: null,
          first_name: null,
          last_name: null,
          username: null,
          email: null,
          role_id: null,
          password: null,
          profile_attributes: {
           id: null,
           english_level: null,
           cv_link: null,
           technical_experience: null,
          }
        },
        english_levels: [
          { name: "No Experience",id: 'no_experience'},
          { name: "A2",id: 'a2'},
          { name: "B1",id: 'b1'},
          { name: "B2",id: 'b2'},
          { name: "C1",id: 'c1'},
          { name: "C2",id: 'c2'}
        ]
      }
    },
    methods: {
      checkForm: function(e){

        this.errors = []

        if( !this.user.first_name){
          this.errors.push('First name is required')
        }

        if( !this.user.username){
          this.errors.push('Username is required')
        }

        if( !this.user.profile_attributes.english_level){
          this.errors.push('English Level is required')
        }

        if (!this.user.email) {
          this.errors.push('Email is required')
        } else if (!this.validEmail(this.user.email)) {
          this.errors.push('Invalid email address');
        }

        if( !this.user.id ){
          if (!this.user.password || !this.confirm_password ) {
            this.errors.push('Password and Confirm Password are required')
          } else if ( this.user.password.length < 6 ) {
            this.errors.push('Password is too short (minimum is 6 characters)');
          }else if ( this.user.password != this.confirm_password ) {
            this.errors.push('Password and Confirm Password should be the same');
          }
        }

        if (!this.errors.length) {
          if(this.user.id){
            this.EditUser()
          }else{
            this.CreateUser()
          }
        }

        e.preventDefault()
      },
      validEmail: function (email) {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
      },
      CreateUser: function (){
        axios.post("/api/v1/users", {user: this.user} )
          .then( (response) => {
            if(response.status === 201) {
               this.$router.push({ path : '/users/'+ response.data.user.id  });
            }
          } );
      },
      EditUser: function (){
        let user = this.user
        delete user['password']
        delete user['email']

        axios.put("/api/v1/users/" + this.$route.params.id, {user: user} )
          .then( (response) => {
            if(response.status === 200) {
               this.$router.push({ path : '/users/'+ response.data.user.id  });
            }
          } );
      }
    },
    mounted () {
      axios
        .get('/api/v1/roles/roles_select')
        .then( (response) => { this.roles = response.data.roles } )

      if( this.$route.params.id ){
        this.$store.commit('setTitle', 'Edit User')
        this.form_action = 'Update'
        axios
          .get('/api/v1/users/' + this.$route.params.id)
          .then( (response) => { this.user = response.data.user } )
      }else{
        this.$store.commit('setTitle', 'New User')
      }

      /*axios
        .get('http://localhost/api/v1/users/id')
        .then( (response) => { this.data = response.data.accounts } )*/

    }
  }
</script>