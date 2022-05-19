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
            <th scope="col">{{user.english_level}}</th>
            <th scope="col"><a :href="getUrl(user.id)">View</a></th>
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
      getUrl(user_id){
        return "/#/users/" + user_id
      }
    },
    mounted () {
      this.$store.commit('setTitle', 'List of Users')
      axios
        .get('/api/v1/users')
        .then( (response) => { this.data = response.data.users } )

    }
  }
</script>