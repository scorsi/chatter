import "phoenix_html"
import Elm from "./../elm/Main.elm"
import socket from "./socket"
import $ from "jquery"


const elmContainer = $('#elm-container')
const elmApp = Elm.Main.embed(elmContainer[0])


const channel = socket.channel('chat_room:lobby', {})
const list = $('#message-list')
const message = $('#msg')
const name = $('#name')

message.on('keypress', event => {
    if (event.keyCode == 13) {
        channel.push('shout', {
            name: name.val(),
            message: message.val()
        })
        message.val('')
    }
});

channel.on('shout', payload => {
    list.append(`<b>${payload.name || 'new_user'}:</b> ${payload.message}<br>`)
    list.prop({
        scrollTop: list.prop('scrollHeight')
    })
})

channel
    .join()
    .receive('ok', resp => {
        console.log('Joined successfully', resp)
    })
    .receive('error', resp => {
        console.log('Unable to join', resp)
    })
