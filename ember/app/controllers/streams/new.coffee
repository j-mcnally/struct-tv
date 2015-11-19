`import ic from 'ic-ajax'`
NewController = Ember.Controller.extend
  # Implement github repo lookup.
  repos: []
  meetups: []
  myMeetups: []
  filterWorking: false

  filterMeetup: (term) ->
    @set('meetups', 
      @get('myMeetups').filter( (item, index, list) ->
        (item.get('name').indexOf(term) > -1) 
      )
    )

  filterGithub: (term) ->
    self = this
    @set('filterWorking', true)
    ic("https://api.github.com/search/repositories?q=#{term}&sort=stars&order=desc").then (response) ->
      self.set('repos', response.items)
      self.set('filterWorking', false)

  actions:
    submit: ->
      self = this
      self.set('errors', null)
      @get('model').validate().then(->
        self.get('model').save().then (stream)->
          self.set('model', self.store.createRecord('stream', {}))
          self.set('repo', null)
          self.get('session.currentUser').set('current_stream', stream)
      , ->
        errors = self.get('model.errors')
        console.log errors
        self.set('errors', errors)
      )

    filterMeetupsWithXHR: (autocomplete, term) ->
      this.filterMeetup(term)

    filterReposWithXHR: (autocomplete, term) ->
      Ember.run.debounce(this, this.filterGithub, [term], 1000)
    
    updateMeetup: (autocomplete) ->
      meetup_id = autocomplete.get('value')
      @get('model').set('ext_id', meetup_id)
      @get('model').set('ext_provider', "Meetup")
      @set('meetup', @get('meetups').findBy("id", meetup_id))

    updateRepo: (autocomplete) ->
      repo_id = autocomplete.get('value')
      @get('model').set('ext_id', repo_id)
      @get('model').set('ext_provider', "Github")
      @set('repo', @get('repos').findBy("id", repo_id))

`export default NewController`