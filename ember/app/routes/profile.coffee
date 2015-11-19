`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';`

ProfileRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @session.get('currentUser')

`export default ProfileRoute`