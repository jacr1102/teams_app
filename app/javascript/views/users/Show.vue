<template>
  <div class="">
    <div class="border container px-4 py-4">
        <div class="col-md-6 mx-auto">
          <div class="row">
            <label class="col-md-4 fw-bold">Name:</label>
            <p class="col-md-8">{{data.name}}</p>
          </div>
          <div class="row">
              <label class="col-md-4 fw-bold">Email:</label>
              <p class="col-md-8">{{data.email}}</p>
          </div>
          <div class="row">
              <label class="col-md-4 fw-bold">Role:</label>
              <p class="col-md-8">{{data.role}}</p>
          </div>
          <div class="row">
            <label class="col-md-4 fw-bold">English level:</label>
            <p class="col-md-8" v-if="data.profile_attributes">{{data.profile_attributes.english_level}}</p>
          </div>
          <div class="row">
            <label class="col-md-4 fw-bold">CV Link:</label>
            <p class="col-md-8" v-if="data.profile_attributes">{{data.profile_attributes.cv_link}}</p>
          </div>
          <div class="row">
            <label class="col-md-4 fw-bold">Technical Experience:</label>
            <p class="col-md-8" v-if="data.profile_attributes">{{data.profile_attributes.technical_experience}}</p>
          </div>
        </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'ShowUser',
    data: function(){
      return {
        data: [],
      }
    },
    mounted () {
      this.$store.commit('setTitle', 'User')
      axios
        .get('/api/v1/users/'+this.$route.params.id, { headers: { 'Authorization' : this.$store.state.access_token } })
        .then( (response) => { this.data = response.data.user } )



    }
  }
</script>