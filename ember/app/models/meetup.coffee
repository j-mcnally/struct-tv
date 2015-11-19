Meetup = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  link: DS.attr 'string'
  image: DS.attr 'string'

  cleanDesc: (->
    $("<div></div>").html(@get('description')).text()
  ).property('description')

`export default Meetup`