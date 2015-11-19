User = DS.Model.extend
  username: DS.attr 'string'
  avatar_url: DS.attr 'string', {readOnly: true}
  email: DS.attr 'string'
  profile: DS.attr 'string'
  streams: DS.hasMany 'stream', {readOnly: true}
  authorizations: DS.hasMany 'authorization', {readOnly: true}
  current_stream: DS.belongsTo 'stream', {readOnly: true}
  
  hasGithub: (->
    @get('authorizations').findBy('oauth_provider', 'Github')
  ).property('authorizations.[]')

  hasMeetup: (->
    @get('authorizations').findBy('oauth_provider', 'Meetup')
  ).property('authorizations.[]')

  current_streamkey: (->
    "#{@get('username')}?key=#{@get('current_stream.streamkey')}"
  ).property('username', 'current_stream.streamkey')

  formattedProfile: (->
    marked(@get('profile') || "")
  ).property('profile')

`export default User`