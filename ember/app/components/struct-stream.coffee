`import config from '../config/environment'`

StructStream = Ember.Component.extend
  tagName: 'div'
  classNames: ['stream-content', 'scrolling']



  tearDown: (->
    $(window).off("resize", this.onResize)
    clearTimeout(@get('waitStart')) if @get('waitStart')
    clearTimeout(@get('waitStop')) if @get('waitStop')
    @get('socket').leave("messages", "#{@get('stream.id')}")
  ).on('willDestroyElement')

  onResize: (e) ->
    self = e.data.caller
    Ember.run.debounce(self, ->
      self.$().height($(window).height() - 52)
    , 500)

  messageConnect: (channel, self) ->
    channel.on("start:stream", (message) ->
      clearTimeout(self.get('waitStart')) if self.get('waitStart')
      waitStart = setTimeout(->
        self.get('stream').set('started_at', message.stream.started_at)
        self.get('stream').set('ended_at', message.stream.ended_at)
      , 10000);
      self.set('waitStart', waitStart)
    )
    channel.on("stop:stream", (message) ->
      clearTimeout(self.get('waitStop')) if self.get('waitStop')
      waitStop = setTimeout(->
        self.get('stream').set('started_at', message.stream.started_at)
        self.get('stream').set('ended_at', message.stream.ended_at)
      , 10000);
      self.set('waitStop', waitStop)
    )
    channel.on("update:stream", (message) ->
      self.get('stream').set('title', message.stream.title)
      self.get('stream').set('description', message.stream.description)
    )
    channel.on("viewer_change:stream", (message) ->
      self.get('stream').set('viewers_total', message.stream.viewers_total)
      self.get('stream').set('viewers_current', message.stream.viewers_current)
    )

  setupWebsocket: ->
    self = this
    socket = new Phoenix.Socket(config.WEBSOCKET_ENDPONT + "/ws")
    @set('socket', socket)
    socket.join("streams", "#{@get('stream.id')}", {}, (channel) ->
      self.messageConnect(channel, self)
    )


  _init: (->
    $(window).resize({caller: this}, this.onResize)
    this.onResize({data: {caller: this}})
    this.setupWebsocket()
  ).on('didInsertElement')

  actions:
    updateStream: ->
      @set('editing', false)
      @get('stream').save()



`export default StructStream`