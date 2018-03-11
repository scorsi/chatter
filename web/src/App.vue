<template lang="jade">

v-app
  v-navigation-drawer(app v-model="sideNav")
    v-list
      v-list-tile
        v-list-tile-action
          v-icon supervisor_account
        v-list-tile-content View meetups

  v-toolbar(app).primary
    v-toolbar-side-icon(@click.native.stop="sideNav = !sideNav").hidden-sm-and-up
    v-toolbar-title Chatter
    v-spacer
    v-toolbar-items.hidden-xs-only
      v-btn(flat) Login

  v-content
    v-container(fluid)
      p Hello

  v-footer(app)

</template>

<script>
export default {
  data () {
    return {
      sideNav: false
    }
  },
  name: 'App'
}
</script>

<style lang="stylus">

</style>
