PopularRoute = Ember.Route.extend
  model: (params) ->
    @store.findQuery('stream', {popular: true})

`export default PopularRoute`