StrobePlayer = Ember.Component.extend
  
  stream: null
  player: null
  width:  "100%"
  height: "100%"
  setup: false
  mobile: false

  tearDown: (->
    $(window).off("resize", this.onResize)
  ).on('willDestroyElement')

  embeded: (e, context) ->
    context.set('player', e.ref)
    width = $(e.ref).innerWidth()
    $(e.ref).height(width * 0.625)

  onResize: (e) ->
    self = e.data.caller
    Ember.run.debounce(self, ->
      if self.get('player')
        width = $(self.get('player')).innerWidth()
        $(self.get('player')).height(width * 0.625)
    , 500)


  recordingChange: (->
    if @get('setup')
      @setupPlayer()
    else
      @get('player').load("#{@get('play_recording.fullpath')}")
      @get('player').play2()

  ).observes('play_recording')


  setupPlayer: ->
    self = this
    if @get('mobile')

    else
      if @get('stream') && @get('isPlaying')
        
        window["onJSBridge#{@get('stream.id')}"] = (playerId, event, data) ->
          if (event == "complete")
            window.setTimeout(->
              self.set('play_recording', null)
            , 1000)                  

        flashvars =
          src: "#{@get('stream.streamUrl')}&autoPlay=true"
          javascriptCallbackFunction: "onJSBridge#{@get('stream.id')}"
          plugin_hls: "/swf/HLSDynamicPlugin.swf"
          plugin_pseudo: "/swf/NginxPseudoStreamingPlugin.swf"
        
        if @get('play_recording')
          flashvars["autoPlay"] = true
          flashvars["src"] = "#{@get('play_recording.fullpath')}"
          flashvars["src_nginxPseudoStreamingQuery"] = "start={0}"
          flashvars["autoRewind"] = false

        params =
          allowFullScreen: true
          allowScriptAccess: "always"
        attrs =
          name: "player"
        
        swfobject.embedSWF("/swf/GrindPlayer.swf", "strobe-player", "#{@get('width')}", "#{@get('height')}", "10.2", null, flashvars, params, attrs, ((e) ->
          self.set('setup', true)
          self.embeded(e, self)
        ));
        

  _init: (->
    # Sniff for mobile
    md = new MobileDetect(window.navigator.userAgent)
    @set('mobile', md.mobile())             
    @setupPlayer()
    $(window).resize({caller: this}, this.onResize)
  ).on('didInsertElement')

`export default StrobePlayer`