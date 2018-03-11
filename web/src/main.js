import Vue from 'vue'
import App from '@/App'
import router from '@/router'
import Vuetify from 'vuetify'
import { ApolloClient } from 'apollo-client'
import { HttpLink } from 'apollo-link-http'
import { InMemoryCache } from 'apollo-cache-inmemory'
import VueApollo from 'vue-apollo'
import gql from 'graphql-tag'
import '@/stylus/main.styl'

const apolloClient = new ApolloClient({
  link: new HttpLink({
    uri: 'http://localhost:4000/api'
  }),
  cache: new InMemoryCache(),
  connectToDevTools: true
})

apolloClient.query({
  query: gql`
    {
      users {
        id,
        username,
        email
      }
    }`
}).then((data) => {
  console.log(data)
}).catch((error) => {
  console.log(error)
})

Vue.use(VueApollo)

const apolloProvider = new VueApollo({
  defaultClient: apolloClient
})

Vue.use(Vuetify)

Vue.config.productionTip = false

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  provide: apolloProvider.provide(),
  render: h => h(App)
})
