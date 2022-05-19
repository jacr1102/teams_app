<template>
  <div>
    <div class="table-responsive">
      <table class="table table-bordered" :items="data" :fields="fields">
        <thead class="thead-dark">
          <tr>
            <th scope="col">id</th>
            <th scope="col">Name</th>
            <th scope="col">Client Name</th>
            <th scope="col"></th>
            <th scope="col">Options</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="account in data" v-bind:key="account.id" >
            <th scope="col">{{account.id}}</th>
            <th scope="col">{{account.name}}</th>
            <th scope="col">{{account.client_name}}</th>
            <th scope="col"></th>
            <th scope="col"><a href="">View</a></th>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Accounts',
    data: function(){
      return {
        fields: ['id','name','client_name'],
        data: [],
      }
    },
    mounted () {
      this.$store.commit('setTitle', 'List of Accounts')
      axios
        .get('http://localhost/api/v1/accounts')
        .then( (response) => { this.data = response.data.accounts } )

    }
  }
</script>