
import { Socket } from "phoenix"
import $ from "jquery"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("room:lobby", {})


const message = $('#message-input')
const nickName = 'Nickname'
const chatMessages = $('#chat-messages')

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


channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
