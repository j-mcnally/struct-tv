Channel = DS.Model.extend
  github_id: DS.attr 'number'
  title: DS.attr 'string'
  description: DS.attr 'string'
  project_url: DS.attr 'string'
  image: DS.attr 'string'
  streams: DS.hasMany 'stream'


  textDescription: (->
    jQuery("<div></div>").html(@get('description')).text()
  ).property('description')

`export default Channel`