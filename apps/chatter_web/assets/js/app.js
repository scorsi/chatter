import "phoenix_html"
import Vue from "vue"
import App from "../components/app.vue"

Vue.component("app", App)

new Vue({
    el: "#app",
    render(createElement) {
        return createElement(App, {})
    }
})
