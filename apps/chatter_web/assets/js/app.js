
import "phoenix_html"

import $ from "jquery"
import Vue from 'vue'

//import socket from "./socket"

import App from "../components/app.vue"

Vue.component('app', App)

new Vue({
    el: '#app',
    render(createElement) {
        return createElement(App, {})
    }
})
