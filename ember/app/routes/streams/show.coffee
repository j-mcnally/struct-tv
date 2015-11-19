`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';`

ShowRoute = Ember.Route.extend
  model: (params) ->
    @store.find('stream', params.id)
  afterModel: (model) ->
    unless model.get('full')
      model.reload().then((stream) ->
        stream.incrementProperty('viewers_current')
        stream.incrementProperty('viewers_total')
      )
    # Increment these since they wont account for us

  setupController: (controller, model) ->
    @_super(controller, model)
    # Move this to teardown of a controller maybe?
    controller.set('play_recording', null)


`export default ShowRoute`