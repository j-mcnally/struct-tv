`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';`

IndexRoute = Ember.Route.extend
  setupController: (controller, model) ->
    self = this
    @store.find('stream', 'featured').then (stream) ->
      controller.set('stream', stream)
      self._super(controller, model)


`export default IndexRoute`