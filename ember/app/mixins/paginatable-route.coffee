paginatable = Ember.Mixin.create
  queryParams: {
    page: {
      refreshModel: true
    }
  },
  setupController: (controller, model) ->
    @_super(controller, model)
    meta = model.get('meta')
    if meta && meta.page_count
      controller.set('pageCount', meta.page_count)



`export default paginatable`