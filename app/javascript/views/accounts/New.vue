<template>
  <div>
    <div class="border container px-4 py-4">
      <form class="row g-3"
        id="create_account"
        @submit="checkForm"
        method="post">
          <p v-if="errors.length" class="text-danger fw-bold">
            <b>Validation errors:</b>
            <ul>
              <li v-for="error in errors">{{ error }}</li>
            </ul>
          </p>

          <div class="col-md-6 text-start">
            <label for="account_name" class="form-label fw-bold">Account Name</label>
            <input v-model="account.name" type="text" class="form-control" name="account[name]" id="account_name" >
          </div>
          <div class="col-md-6 text-start" >
            <label for="account_client_name" class="form-label fw-bold">Client Name</label>
            <input v-model="account.client_name" type="text" class="form-control" name="account[client_name]" id="account_client_name" >
          </div>
          <div class="col-md-12 text-start">
            <label for="account_user_id" class="form-label fw-bold">Account Manager</label>
            <select v-model="account.user_id"  class="form-select" name="account[user_id]" id="account_user_id">
              <option v-for="manager in managers" :value="manager.id" >{{manager.name}}</option>
            </select>
          </div>
          <div class="col-md-12 text-start">
            <label for="account_team_ids" class="form-label fw-bold">Team Members</label>
            <!--<multiselect
              v-model="account.team_ids"
              :options="team_members"
              :multiple="true"
              :close-on-select="true"
              placeholder="Select Team Members"
              label="name"
              track-by="name"
              :searchable="true"
               >
            </multiselect>-->
            <select v-model="account.team_ids" multiple="multiple"  class="form-select select2_multiple" name="account[team_ids]" id="account_team_ids">
              <option v-for="user in team_members" :value="user.id" >{{user.name}}</option>
            </select>
          </div>

          <div class="col-12 ">
            <button type="submit" class="btn btn-primary">{{form_action}} Account</button>
          </div>
      </form>
    </div>
  </div>
</template>

<script>

  import Multiselect from 'vue-multiselect'

  //Vue.use(Multiselect);

  export default {
    name: 'NewUser',
    components:{
      Multiselect
    },
    data: function(){
      return {
        errors: [],
        form_action: 'Create',
        account: {
          id: null,
          name: null,
          client_name: null,
          user_id: null,
          team_ids: []
        },
        managers: [],
        team_members: []
      }
    },
    methods: {
      checkForm: function(e){

        this.errors = []

        if( !this.account.name){
          this.errors.push('Account name is required')
        }

        if( !this.account.client_name){
          this.errors.push('Client name is required')
        }

        if (!this.errors.length) {
          if(this.account.id){
            this.editAccount()
          }else{
            this.createAccount()
          }
        }

        e.preventDefault()
      },
      validEmail: function (email) {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
      },
      async getAccount(){
        const response = await this.$store.state.auth.get( '/api/v1/accounts/' + this.$route.params.id )

        if(response.status === 200) {
          this.account = {
              id: response.data.account.id ,
              name: response.data.account.name,
              client_name: response.data.account.client_name,
              user_id: response.data.account.user_id,
              team_ids: response.data.account.team_ids
            }
        }
      },
       async createAccount(){
          axios.post("/api/v1/accounts", {account: this.account}, { headers: { 'Authorization' : this.$store.state.access_token } } )
            .then( (response) => {
              if(response.status === 201) {
                 this.$router.push({ path : '/accounts/'+ response.data.account.id  });
              }
            } );
        },
        async editAccount(){
          axios.put("/api/v1/accounts/" + this.$route.params.id, {account: this.account}, { headers: { 'Authorization' : this.$store.state.access_token } } )
            .then( (response) => {
              if(response.status === 200) {
                 this.$router.push({ path : '/accounts/'+ response.data.account.id  });
              }
            } );
        }
    },
    mounted () {
      axios
        .get('/api/v1/users/users_select', { headers: { 'Authorization' : this.$store.state.access_token } } )
        .then( (response) => {
          this.managers     = response.data.users
          this.team_members = response.data.users
        } )

      if( this.$route.params.id ){
        this.$store.commit('setTitle', 'Edit Account')
        this.form_action = 'Update'
        this.getAccount()
      }else{
        this.$store.commit('setTitle', 'New Account')
      }

    }
  }
</script>

<style src="vue-multiselect/dist/vue-multiselect.min.css"></style>