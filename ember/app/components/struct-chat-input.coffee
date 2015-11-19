StructChatInput = Ember.Component.extend
  tagName: 'div'
  classNames: 'chat-message-input'

  _tearDown: (->
    @get('newmessage').rollback()
  ).on("willDestroyElement")

  _init: (->
    @set('newmessage', @store.createRecord('message'))
  ).on("didInsertElement")

  actions:
    sendMessage: ->
      self = this
      if @get('me')
        return if !@get('newmessage.body')? or @get('newmessage.body').length == 0
        @get('newmessage').set('sender', @get('me').get('username'))
        @get('newmessage').set('stream', @get('stream'))
        msg = @get('newmessage')
        @set('newmessage', self.store.createRecord('message'))
        msg.save()
      else
        alert("Please login to send message.")
        @get('newmessage').set('body', "")


`export default StructChatInput`