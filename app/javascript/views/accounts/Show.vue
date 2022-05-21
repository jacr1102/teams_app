<template>
  <div class="">
    <div class="border container px-4 py-4">
        <div class="col-md-6 mx-auto my-5">
          <div class="row">
            <label class="col-md-4 fw-bold">Account Name:</label>
            <p class="col-md-8">{{data.name}}</p>
          </div>
          <div class="row">
              <label class="col-md-4 fw-bold">Client name:</label>
              <p class="col-md-8">{{data.client_name}}</p>
          </div>
          <div class="row">
              <label class="col-md-4 fw-bold">Account manager:</label>
              <p class="col-md-8">{{data.account_manager}}</p>
          </div>
        </div>
        <div class="col-md-6 mx-auto">
          <div class="row">
            <div class="container my-5">
              <h2>Team</h2>
              <div class="table-responsive">
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th>Name</th>
                      <th>Role</th>
                      <th>Email</th>
                      <th>English Level</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr v-for="user in data.team" v-bind:key="user.id" >
                      <th scope="col">{{user.name}}</th>
                      <th scope="col">{{user.role}}</th>
                      <th scope="col">{{user.email}}</th>
                      <th scope="col">{{user.profile_attributes.english_level}}</th>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'ShowAccount',
    data: function(){
      return {
        data: [],
      }
    },
    mounted () {
      this.$store.commit('setTitle', 'Account')
      axios
        .get('/api/v1/accounts/'+this.$route.params.id, { headers: { 'Authorization' : this.$store.state.access_token } })
        .then( (response) => { console.log(response.data); this.data = response.data.account } )



    }
  }
</script>