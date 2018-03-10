<template>
  <div class="my-app">
    <h1>Chatter</h1>

    <div class="user-details">
      <label>Please enter your name:</label><br>
      <input type="text" v-model="username">
      <button v-on:click="connectToLobby">Next</button>
    </div>

    <ul v-for="message in messages">
      <li>
        <small>{{message.received_at}}</small>: <strong>{{message.username}}</strong> {{message.body}}
      </li>
    </ul>

    <input type="text" v-model="message" v-on:keyup.13="sendMessage">
  </div>
</template>

<script>
import { Socket, Presence } from "phoenix"

export default {
  data() {
    return {
      socket: null,
      channel: null,
      messages: [],
      username: "",
      message: ""
    }
  },
  methods: {
    sendMessage() {
      this.channel.push("message:new", {
        body: this.message
      })
      this.message = ""
    },
    
    connectToLobby() {
      this.socket = new Socket("/socket", {
        params: {
          // token: window.userToken,
          username: this.username
        }
      })
      this.socket.connect()

      this.channel = this.socket.channel("room:lobby", {})

      this.channel.on("message:new", payload => {
        payload.received_at = Date();
        this.messages.push(payload);
      })

      this.channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })
    }
  }
}
</script>

<style lang="sass">
.my-app {
  margin-left: auto;
  margin-right: auto;
  width: 800px;

  h1 {
    text-align: center;
  }
}
</style>