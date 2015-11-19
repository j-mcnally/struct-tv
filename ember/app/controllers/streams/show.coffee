ShowController = Ember.Controller.extend
  messages: []
  isPlaying: (->
    @get('model.isLive') || @get('play_recording')
  ).property('model.isLive', 'play_recording')

`export default ShowController`