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
      title: ''
      user: null,
      token: null
    },
    methods: {
      getToken(){
        axios.post("/logins", {user: this.user} )
          .then( (response) => {
            if(response.status === 201) {
               /* Store Token*/
               /* Redirect when logout */
            }
          } );
      }
    },
    mutations: {
      setTitle(state,title){
        state.title = title
      }
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
