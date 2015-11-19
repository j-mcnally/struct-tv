ProfileController = Ember.Controller.extend
  actions:
    updateUser: ->
      self = this
      @get('model').save().then(->
        self.transitionToRoute('index')
      , (error) ->
        alert("There was a problem saving your profile.")
        self.get('model').rollback()
      )

`export default ProfileController`