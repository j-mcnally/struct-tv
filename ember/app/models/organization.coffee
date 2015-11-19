Organization = DS.Model.extend
  slug_name: DS.attr 'string'
  human_name: DS.attr 'string'
  avatar: DS.attr 'string'
  name: (->
    @get('human_name') || @get('slug_name')
  ).property('slug_name', 'human_name')


`export default Organization`