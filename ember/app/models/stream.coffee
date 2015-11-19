`import config from '../config/environment'`

Stream = DS.Model.extend Ember.Validations.Mixin,
  ext_id: DS.attr 'number'
  ext_provider: DS.attr 'string'
  title: DS.attr 'string'
  description: DS.attr 'string'
  full: DS.attr 'boolean', {readOnly: true}
  started_at: DS.attr 'date', {readOnly: true}
  ended_at: DS.attr 'date', {readOnly: true}
  viewers_current: DS.attr 'number', {readOnly: true}
  viewers_total: DS.attr 'number', {readOnly: true}
  streamkey: DS.attr 'string', {readOnly: true}
  user: DS.belongsTo 'user', {readOnly: true, inverse: 'streams'}
  channel:  DS.belongsTo 'channel', {readOnly: true}
  recordings: DS.hasMany 'recordings', {readOnly: true}
  messages: DS.hasMany 'message', {readOnly: true}


  publicUrl: (->
    "#{config.APP_ENDPOINT}/streams/#{@get("id")}"
  ).property('id')

  streamUrl: (->
    "#{config.STREAM_ENDPOINT}/hls/#{@get('user.username')}.m3u8"
  ).property('user', 'user.username')
  shareText: (->
    "Now streaming: #{@get('title')}"
  ).property("title")

  formattedDescription: (->
    marked(@get('description') || "")
  ).property('description')

  isLive: (->
    @get('started_at') && !@get('ended_at')
  ).property('started_at', 'ended_at')

  validations:
    ext_id:
      presence: true,
      numericality: true
    title:
      presence: true

`export default Stream`