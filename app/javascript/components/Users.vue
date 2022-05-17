<template>
  <div class="table-responsive">
    <table class="table table-bordered" :items="data" :fields="fields">
      <thead class="thead-dark">
        <tr>
          <th scope="col">id</th>
          <th scope="col">Name</th>
          <th scope="col">email</th>
          <th scope="col">English Level</th>
          <th scope="col">Options</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in data" v-bind:key="user.id" >
          <th scope="col">{{user.id}}</th>
          <th scope="col">{{user.name}}</th>
          <th scope="col">{{user.email}}</th>
          <th scope="col">{{user.english_level}}</th>
          <th scope="col"><a href="">View</a></th>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    name: 'Users',
    data: function(){
      return {
        fields: ['id','name','email'],
        data: [],
      }
    },
    mounted () {
      axios
        .get('http://localhost/api/v1/users')
        .then( (response) => { this.data = response.data.users } )

    }
  }
</script>
this.data = response["users"];