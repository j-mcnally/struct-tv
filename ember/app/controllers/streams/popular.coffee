PopularController = Ember.ArrayController.extend
  
  liveNow: (->
    @get('model').filterBy('isLive', true)
  ).property('model.[]')

  old: (->
    @get('model').filterBy('isLive', false)
  ).property('model.[]')


`export default PopularController`