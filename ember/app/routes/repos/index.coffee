`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin';`
`import PaginatableRouteMixin from 'struct/mixins/paginatable-route';`

IndexRoute = Ember.Route.extend PaginatableRouteMixin,
  model: (params) ->
    @store.find('repo', params)

`export default IndexRoute`