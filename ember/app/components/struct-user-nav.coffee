StructUserNav = Ember.Component.extend
  tagName: 'ul'
  classNames: ['nav', 'navbar-nav', 'navbar-right']
  actions:
    loginAction: ->
      this.sendAction('loginAction')
`export default StructUserNav`