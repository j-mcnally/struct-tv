`import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin'`;

ApplicationRoute = Ember.Route.extend ApplicationRouteMixin,
  beforeModel: ->
    # Setup hardcoded Auth
    if window.auth_token? && window.auth_token != ""
      @loginSession(window.auth_token)
      @get('session.currentUser')
    else
      if @session.isAuthenticated
        @destroySession()


  loginSession: (token) ->

    # Inject embeded token into the session store
    @session.store.persist({auth_token: token, authenticator: "authenticator:elixir-github"})
    @session.restore()

  destroySession: ->
    @session.invalidate()

  actions: {
    openLoginModal: ->
      this.render('login',
        into: 'application',
        outlet: 'modal'
      )
    closeLoginModal: ->
      this.disconnectOutlet({
        outlet: 'modal',
        parentView: 'application'
      })
  }


`export default ApplicationRoute`