<template>
  <div>
    <div class="table-responsive">
      <table class="table table-bordered" :items="data" :fields="fields">
        <thead class="thead-dark">
          <tr>
            <th scope="col">id</th>
            <th scope="col">Name</th>
            <th scope="col">Role</th>
            <th scope="col">email</th>
            <th scope="col">English Level</th>
            <th scope="col">Options</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in data" v-bind:key="user.id" >
            <th scope="col">{{user.id}}</th>
            <th scope="col">{{user.name}}</th>
            <th scope="col">{{user.role}}</th>
            <th scope="col">{{user.email}}</th>
            <th scope="col">{{user.profile_attributes.english_level}}</th>
            <th scope="col">
              <a :href="getUrl(user.id)" class="btn btn-primary">View</a>
              <a :href="getEditUrl(user.id)" class="btn btn-success">Edit</a>
              <a href="#" @click="deleteUser(user.id)" class="btn btn-danger">Delete</a>
            </th>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Users',
    data: function(){
      return {
        fields: ['id','name','role','email','english_level'],
        data: [],
      }
    },
    methods: {
      async getUsers(){
        const response = await this.$store.state.auth.get( '/api/v1/users' )
        if( response.status == 200 ){
          this.data = response.data.users
        }
      },
      getUrl(user_id){
        return "/#/users/" + user_id
      },
      getEditUrl(user_id){
        return "/#/users/" + user_id + "/edit"
      },
      async deleteUser(user_id){
        if( confirm("Are you sure to remove this user?") ){
          const response = await this.$store.state.auth.delete( '/api/v1/users/' + user_id )
          if( response.status == 200 ){
            this.getUsers()
          }
        }
      }
    },
    mounted () {
      this.$store.commit('setTitle', 'List of Users')
      this.getUsers()
    }
  }
</script>