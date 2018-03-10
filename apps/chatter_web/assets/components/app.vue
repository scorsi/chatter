<template>
  <div class="my-app">
    <h1>Chatter</h1>

    Online users:
    <ul v-for="user in users">
      <li>
        {{user.user}} ({{user.online_at}})
      </li>
    </ul>

    Messages:
    <ul v-for="message in messages">
      <li>
        <small>{{message.received_at}}</small> <strong>{{message.username}}</strong>: {{message.body}}
      </li>
    </ul>

    <input type="text" v-model="message" v-on:keyup.13="sendMessage">
  </div>
</template>

<script>
import socket from "../js/socket"
import { Presence } from "phoenix"

export default {
  data() {
    
    let messages = []
    let users = []
    let presences = {}

    let channel = socket.channel("room:lobby", {})

    channel.on("message:new", payload => {
      payload.received_at = Date();
      messages.push(payload);
    })

    channel.on("presence_state", state => {
      presences = Presence.syncState(presences, state)
      this.assignUsers(presences)
    })
    channel.on("presence_diff", diff => {
      presences = Presence.syncDiff(presences, diff)
      this.assignUsers(presences)
    })

    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })


    return {
      channel: channel,
      messages: messages,
      users: users,
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

    assignUsers(presences) {
      let formatTimestamp = (timestamp) => {
        timestamp = parseInt(timestamp)
        let date = new Date(timestamp)
        return date.toLocaleTimeString()
      }

      this.users = Presence.list(presences, (user, {metas: metas}) => {
        return { user: user, online_at: formatTimestamp(metas[0].online_at) }
      })
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