`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';`

FollowingRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.findQuery('stream', {following: true})

`export default FollowingRoute`