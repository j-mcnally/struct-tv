StructEditStreamButton = Ember.Component.extend
  tagName: 'div'
  canEdit: (->
    @get('me.id') == @get('stream.user.id')
  ).property('me', 'stream', 'stream.user')

  actions:
    edit: ->
      @set('editing', true)

    cancel: ->
      @get('stream').rollback()
      @set('editing', false)




`export default StructEditStreamButton`