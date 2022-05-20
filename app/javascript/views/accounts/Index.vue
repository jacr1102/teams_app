<template>
  <div>
    <div class="table-responsive">
      <table class="table table-bordered" :items="data" :fields="fields">
        <thead class="thead-dark">
          <tr>
            <th scope="col">id</th>
            <th scope="col">Name</th>
            <th scope="col">Client Name</th>
            <th scope="col">Account Manager</th>
            <th scope="col">Options</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="account in data" v-bind:key="account.id" >
            <th scope="col">{{account.id}}</th>
            <th scope="col">{{account.name}}</th>
            <th scope="col">{{account.client_name}}</th>
            <th scope="col">{{account.account_manager}}</th>
            <th scope="col">
              <a :href="getUrl(account.id)" class="btn btn-primary">View</a>
              <a :href="getEditUrl(account.id)" class="btn btn-success">Edit</a>
              <a href="#" @click="deleteAccount(account.id)" class="btn btn-danger">Delete</a>
            </th>
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
    methods: {
      getUrl(account_id){
        return "/#/accounts/" + account_id
      },
      getEditUrl(account_id){
        return "/#/accounts/" + account_id + "/edit"
      },
      deleteAccount(account_id){
        if( confirm("Are you sure to remove this account?") ){
          axios
            .delete('/api/v1/accounts/' + account_id)
            .then( (response) => {
              if(response.status === 200) {
                axios
                  .get('/api/v1/accounts')
                  .then( (response) => { this.data = response.data.accounts } )
              }

             })
        }
      }
    },
    mounted () {
      this.$store.commit('setTitle', 'List of Accounts')
      axios
        .get('/api/v1/accounts')
        .then( (response) => { this.data = response.data.accounts } )

    }
  }
</script>