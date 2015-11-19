IndexController = Ember.Controller.extend
  liveNow: (->
    @get('stream.isLive')
  ).property('stream.isLive')
  
`export default IndexController`