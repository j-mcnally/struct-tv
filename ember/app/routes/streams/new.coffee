`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';`

NewRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.createRecord 'stream', {}

  setupController: (controller, model) ->
    self = this
    @_super(controller, model)
    @get('session').get('currentUser').then (user) ->
      user.reload().then (user) -> 
        if user.get('hasMeetup')    
          self.get('store').find('meetup').then (results) ->
            controller.set('myMeetups', results)
            controller.set('meetups', results)

    controller.set('ext_id', null)
    controller.set('ext_provider', null)
    controller.set('repo', null)

`export default NewRoute`