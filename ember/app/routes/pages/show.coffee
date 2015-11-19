ShowRoute = Ember.Route.extend
  
  model: (params) ->
    params

  setupController: (controller, model) ->
    console.log(model)
    @_super(controller, model)
    jQuery.get('/js/app/help/' + model.id + ".md").success((response) ->
      controller.set('page_body', response)
    )

`export default ShowRoute`