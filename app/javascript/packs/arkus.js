/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue/dist/vue.js'
import Vuex from 'vuex'

import Vuelidate from 'vuelidate'
//import Bootstrap from 'bootstrap'
//import BootstrapVue from 'bootstrap-vue'
//import ElementUI from 'element-ui'

import Router from 'vue-router'
import Home from '../views/Home.vue'

import Users from '../views/users/Index.vue'
  import NewUser from '../views/users/New.vue'
  import ShowUser from '../views/users/Show.vue'

import Accounts from '../views/accounts/Index.vue'
  import NewAccount from '../views/accounts/New.vue'
  import ShowAccount from '../views/accounts/Show.vue'
import Login from '../views/Login.vue'
import Logs from '../views/logs/Index.vue'

import auth from './auth'
import App from '../App.vue'

window.axios = require('axios');

// Creamos una propiedad global para axios
Vue.prototype.$axios = axios

//Vue.use(ElementUI);
// Vue.use(Bootstrap);
Vue.use(Router)
Vue.use(Vuex)


function oles(value){
  console.log(value);
}


document.addEventListener('DOMContentLoaded', () => {
  const router = new Router({
    base: process.env.BASE_URL,
    routes:[
        {
          path: '/',
          name: 'home',
          component: Home
        },
        {
          path: '/users',
          name: 'users',
          component: Users
        },
        {
          path: '/users/new',
          name: 'new_user',
          component: NewUser
        },
        {
          path: '/users/:id/edit',
          name: 'edit_user',
          component: NewUser
        },
        {
          path: '/users/:id',
          name: 'show_user',
          component: ShowUser
        },
        {
          path: '/accounts',
          name: 'accounts',
          component: Accounts
        },
        {
          path: '/accounts/new',
          name: 'new_accounts',
          component: NewAccount
        },
        {
          path: '/accounts/:id/edit',
          name: 'edit_account',
          component: NewAccount
        },
        {
          path: '/accounts/:id',
          name: 'show_accounts',
          component: ShowAccount
        },
        {
          path: '/logs',
          name: 'logs',
          component: Logs
        },
        {
          path: '/login',
          name: 'login',
          component: Login
        }
      ]
  })

  const logged_user = {
        id: null,
        name: null,
        username: null,
        email: null
      }

  const store = new Vuex.Store({
    state:{
      title: '',
      user: {
        email: null,
        password: null
      },
      access_token: null,
      auth: auth,
      logged_in: false,
      logging_in: false,
      username: null,
      logged_user: logged_user,
      login_error: null
    },
    methods: {
    },
    mutations: {

      setTitle(state, title){
        state.title = title
      },
      loginStart: state => state.logging_in = true,
      updateAccessToken: (state, access_token) => {
        state.access_token = access_token;
        state.auth.setHeaders(access_token)
      },
      updateLoggedUser(state, logged_user){
        if(logged_user){
          state.username = logged_user
          state.logged_in = true
        }else{
          state.logged_in = false
        }
      },
      LogIn(state, value){
        state.logged_in = true
      },
      loginStop: (state, errorMessage) => {
        state.logging_in = false;
        state.login_error = errorMessage;
      },

    },
    actions: {
      fetchAccessToken({ commit }) {
        commit('updateAccessToken', localStorage.getItem('access_token'));
        commit('updateLoggedUser', localStorage.getItem('logged_user'));
      }
    },
    created() {

    }
  })

  const app = new Vue({
    render: h => h(App),
    store,
    router
  }).$mount()

  document.body.appendChild(app.$el)

  // console.log(app)
})