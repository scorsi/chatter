<template lang="jade">

v-app
  v-navigation-drawer(app temporary v-model="sideNav")
    v-list
      v-list-tile(v-for="item in menuItems" v-bind:key="item.title" router :to="item.link")
        v-list-tile-action
          v-icon {{ item.icon }}
        v-list-tile-content {{ item.title }}

  v-toolbar(app)
    v-toolbar-side-icon(@click.native.stop="sideNav = !sideNav").hidden-sm-and-up
    v-toolbar-title
      router-link(to="/" tag="span" style="cursor: pointer") Chatter
    v-spacer
    v-toolbar-items.hidden-xs-only
      v-btn(flat v-for="item in menuItems" v-bind:key="item.title" router :to="item.link")
        v-icon(left) {{ item.icon }}
        {{ item.title }}
  
  v-content
    router-view

  v-footer(app)
    p Footer

</template>

<script>
export default {
  data () {
    return {
      sideNav: false,
      menuItems: [
        { icon: 'supervisor_account', title: 'View meetups', link: '/meetups' },
        { icon: 'room', title: 'Organize meetups', link: '/meetup/new' },
        { icon: 'person', title: 'Profil', link: '/profile' },
        { icon: 'face', title: 'Sign up', link: '/signup' },
        { icon: 'lock_open', title: 'Sign in', link: '/signin' }
      ]
    }
  },
  name: 'App'
}
</script>

<style lang="stylus">

</style>
