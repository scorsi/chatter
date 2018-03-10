
import { Socket, Presence } from "phoenix"
import $ from "jquery"
import Vue from 'vue'
import App from "../components/app.vue"

let socket = new Socket("/socket", {params: {token: window.userToken}})
socket.connect()

Vue.component("app", App)

new Vue({
    el: "#app",
    mounted() {
      this.channel = socket.channel("room:lobby", {})

      this.channel.on("message:new", payload => {
        payload.received_at = Date();
        this.messages.push(payload);
      })

      this.channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })
    },
    data() {
      return {
        channel: null,
        messages: []
      }
    },
    render(createElement) {
        return createElement(App, {})
    }
})

export default socket
