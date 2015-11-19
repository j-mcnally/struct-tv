`import config from '../config/environment'`


StructChat = Ember.Component.extend
  tagName: 'div'
  classNames: ['chat']
  messages: []

  tearDown: (->
    $(window).off("resize", this.onResize)
    @get('socket').leave("messages", "#{@get('stream.id')}")
  ).on('willDestroyElement')

  onResize: (e) ->
    self = e.data.caller
    Ember.run.debounce(self, ->
      self.$().height($(window).height() - 94)
    , 500)

  scrollTo: (->
    self = this
    window.setTimeout((->
      self.$().scrollTop(self.$().innerHeight())),
    200)
  ).observes('messages.[]')

  messageConnect: (channel, self) ->
    channel.on("new:message", (message) ->
      message = message.message
      exists = self.store.all('message').findBy('id', message.id)
      unless exists?
        exists = self.store.createRecord('message', message)
      self.get('messages').pushObject(exists)
    )
    
  setupWebsocket: ->
    self = this
    socket = new Phoenix.Socket(config.WEBSOCKET_ENDPONT + "/ws")
    @set('socket', socket)
    socket.join("messages", "#{@get('stream.id')}", {}, (channel) ->
      self.messageConnect(channel, self)
    )


  _init: (->
    $(window).resize({caller: this}, this.onResize)
    this.onResize({data: {caller: this}})
    this.setupWebsocket()
    this.set('messages', [])
  ).on('didInsertElement')


`export default StructChat`