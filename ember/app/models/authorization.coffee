Authorization = DS.Model.extend
  user: DS.belongsTo 'user', {readOnly: true}
  oauth_id: DS.attr 'string'
  oauth_provider: DS.attr 'string'


`export default Authorization`
