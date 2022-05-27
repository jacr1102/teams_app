<template>
  <div>
    <div class="border container px-4 py-4">
      <form class="row g-3"
        id="search_logs"
        @submit="checkForm"
        method="post">

          <div class="col-md-6 text-start">
            <label for="q_user_first_name_or_user_last_name_cont" class="form-label fw-bold">Name</label>
            <input v-model="q.user_first_name_or_user_last_name_cont" type="text" class="form-control" name="q[user_first_name_or_user_last_name_cont]" id="q_user_first_name_or_user_last_name_cont" >
          </div>
          <div class="col-md-6 text-start">
            <label for="q_account_id_eq" class="form-label fw-bold">Account</label>
            <select v-model="q.account_id_eq" class="form-select" id="account_id_eq" name="account_id_eq" >
              <option v-for="account in accounts" :value="account.id">{{account.name}}</option>
            </select>
          </div>
          <div class="col-md-6 text-start">
            <label for="q_created_at_gt" class="form-label fw-bold">From</label>
            <input v-model="q.created_at_gt" type="text" class="form-control" name="q[created_at_gt]" id="q_created_at_gt" >
          </div>
          <div class="col-md-6 text-start">
            <label for="q_created_at_lt" class="form-label fw-bold">To</label>
            <input v-model="q.created_at_lt" type="text" class="form-control" name="q[created_at_lt]" id="q_created_at_lt" >
          </div>
          <div class="col-12 ">
            <button type="submit" class="btn btn-primary">Search</button>
          </div>
      </form>
    </div>
        <div class="">
      <table class="table table-bordered" :items="data" :fields="fields">
        <thead class="thead-dark">
          <tr>
            <th scope="col">id</th>
            <th scope="col">User Name</th>
            <th scope="col">Client Name</th>
            <th scope="col">Action</th>
            <th scope="col">date</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="log in data" v-bind:key="log.id" >
            <th scope="col">{{log.id}}</th>
            <th scope="col">{{log.user_name}}</th>
            <th scope="col">{{log.client_name}}</th>
            <th scope="col">{{log.action}}</th>
            <th scope="col">{{log.created_at}}</th>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'UserLogs',
    data: function(){
      return {
        fields: ['id','name','client','action'],
        data: [],
        accounts: [],
        q: {
          user_first_name_or_user_last_name_cont: '',
          account_id_eq: '',
          created_at_gt: '',
          created_at_lt: '',
        }
      }
    },
    methods: {
      checkForm: function(e){
        e.preventDefault()
        this.getLogs()
      },
      async getLogs(){
        const response = await this.$store.state.auth.post( '/api/v1/user_logs', { q: this.q } )

        if(response.status === 200) {
          this.data = response.data.user_logs
        }
      },
      async getAcounts(){
        const response = await this.$store.state.auth.get( '/api/v1/accounts/accounts_select' )

        if(response.status === 200) {
          this.accounts = response.data.accounts
        }
      }
    },
    mounted () {
      this.$store.commit('setTitle', 'User Logs')
      this.getLogs()
      this.getAcounts()
    }
  }
</script>