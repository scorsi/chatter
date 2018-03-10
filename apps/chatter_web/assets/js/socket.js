
import { Socket, Presence } from "phoenix"
import $ from "jquery"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("room:lobby", {})

const message = $('#message-input')
const nickName = 'Nickname'
const chatMessages = $('#chat-messages')

let presences = {}
const onlineUsers = $('#online-users')[0]

let listUsers = (user) => {
  return {
    user: user
  }
}
let renderUsers = (presences) => {
  onlineUsers.innerHTML = Presence.list(presences, listUsers)
    .map(presence => `<li>${presence.user}</li>`).join("")
}


message.focus()


message.on('keypress', event => {
  if(event.keyCode == 13) {
    channel.push('message:new', {
      message: message.val()
    })
    message.val("")
  }
})

channel.on('message:new', payload => {
  chatMessages.append(`<b>${payload.user}</b>: ${payload.message}<br>`)
  chatMessages.scrollTop = chatMessages.scrollHeight;
})

channel.on('presence_state', state => {
  presences = Presence.syncState(presences, state)
  renderUsers(presences)
})

channel.on('presence_diff', diff => {
  presences = Presence.syncDiff(presences, diff)
  renderUsers(presences)
})


channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
