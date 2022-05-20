/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue/dist/vue.js'
import Vuex from 'vuex'
//import Bootstrap from 'bootstrap'
//import BootstrapVue from 'bootstrap-vue'
import ElementUI from 'element-ui'

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

import App from '../App.vue'

window.axios = require('axios');

// Creamos una propiedad global para axios
Vue.prototype.$axios = axios

Vue.use(ElementUI);
// Vue.use(Bootstrap);
Vue.use(Router)
Vue.use(Vuex)

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

  const store = new Vuex.Store({
    state:{
      title: '',
      user: {
        email: null,
        password: null
      },
      token: null,
      logged_in: true,
      logged_user: null
    },
    methods: {
      getToken(){
        this.token
      }
    },
    mutations: {
      setTitle(state, title){
        state.title = title
      },
      setToken(state, token){
        state.token = token
      }
    },
    created(){

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








export default new Vuex.Store({
  state: {
    accessToken: null,
    loggingIn: false,
    loginError: null
  },
  mutations: {
    loginStart: state => state.loggingIn = true,
    loginStop: (state, errorMessage) => {
      state.loggingIn = false;
      state.loginError = errorMessage;
    },
    updateAccessToken: (state, accessToken) => {
      state.accessToken = accessToken;
    }
  },
  actions: {
    doLogin({ commit }, loginData) {
      commit('loginStart');

      axios.post('https://reqres.in/api/login', {
        ...loginData
      })
      .then(response => {
        localStorage.setItem('accessToken', response.data.token);
        commit('loginStop', null);
        commit('updateAccessToken', response.data.token);
      })
      .catch(error => {
        commit('loginStop', error.response.data.error);
        commit('updateAccessToken', null);
      })
    },
    fetchAccessToken({ commit }) {
      commit('updateAccessToken', localStorage.getItem('accessToken'));
    }
  }
})