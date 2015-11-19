StructRecordingsComponent = Ember.Component.extend
  classNames: ['recording-carousel']
  
  recordingsChange: (->
    self = this
    this.$().unslick();
    this.$().hide()
    # We need to delay till next run loop
    Ember.run.next(self, ->
      this.$().show()
      this.slickit()
    )
  ).observes('recordings.[]')

  slickit: ->

    this.$().slick({
      arrows: true,
      infinite: false,
      slidesToShow: 4,
      slidesToScroll: 1,
      draggable: false,
      touchMove: true,
      centerMode: false,
      speed: 500
    });

  willDestroyElement: ->
    this.$().unslick();

  didInsertElement: ->
    @slickit()
    
  actions:
    play: (recording) ->
      @set('play_recording', recording)

`export default StructRecordingsComponent`