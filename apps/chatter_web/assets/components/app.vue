<template>
  <div class="my-app">
    <div class="row" id="main-container" v-if="this.loaded == false">

      <div class="col s6 offset-s3 valign-wrapper progress">
          <div class="indeterminate"></div>
      </div>
      
    </div>
    <div class="row" id="main-container" v-else>

      <div class="col s3" id="users-list">
        <h3>Online</h3>
        <ul>
          <transition-group name="user-appear">
            <li v-for="user in users" v-bind:key="user.user">
              {{user.user}} ({{user.online_at}})
            </li>
          </transition-group>
        </ul>
      </div>
      <div class="col s9" id="messages-list">
        <ul>
          <transition-group name="message-appear">
            <li v-for="message in messages" v-bind:key="message">
              <div class="message-metadata">
                <span class="username">{{message.username}}</span>
                <span class="received-at">{{message.received_at}}</span>
              </div>

              {{message.body}}
            </li>
          </transition-group>
        </ul>
        <div id="your-message" class="input-field center-align">
          <input type="text" placeholder="Message..." v-model="message" v-on:keyup.13="sendMessage">
        </div>
      </div>
      
    </div>
  </div>
</template>

<script>
import socket from "../js/socket"
import { Presence } from "phoenix"

export default {
  data() {

    let channel = socket.channel("room:lobby", {})

    channel.on("message:new", payload => {
      payload.received_at = Date();
      this.messages.push(payload);
    })

    let presences = {}

    channel.on("presence_state", state => {
      presences = Presence.syncState(presences, state)
      this.assignUsers(presences)
    })
    channel.on("presence_diff", diff => {
      presences = Presence.syncDiff(presences, diff)
      this.assignUsers(presences)
    })

    channel.join()
      .receive("ok", resp => {
        this.loaded = true
      })
      .receive("error", resp => {
      })


    return {
      loaded: false,
      channel: channel,
      messages: [],
      users: [],
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
  h1 {
    text-align: center;
  }
  #main-container {
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    display: flex;
    overflow: hidden;
  }
  #users-list {
    overflow-y: scroll;
    ul {
      padding-left: 20px;
      li {
        &.user-appear-enter-active, &.user-appear-leave-active {
          transition: all .2s
        }
        &.user-appear-enter, &.user-appear-leave-active {
          opacity: 0;
          transform: translateX(-15px);
        }
      }
    }
  }
  #messages-list {
    padding-top: 20px;
    padding-left: 20px;
    overflow-y: scroll;
    flex: 1;
    ul {
      padding: 0;
      li {
        padding: 5px 0;
        &.message-appear-enter-active, &.message-appear-leave-active {
          transition: all .2s
        }
        &.message-appear-enter, &.message-appear-leave-active {
          opacity: 0;
          transform: translateY(20px);
        }
        .message-metadata {
          .username {
            font-weight: bold;
          }
          .received-at {
            margin-left: 5px;
            font-size: 0.9em;
          }
        }
      }
    }
  }
  #your-message {
    padding: 15px;
    input {
      width: 100%;
      padding: 5px 8px;
      border-radius: 3px;
      outline: 0;
    }
  }
}
</style>