`import config from '../config/environment'`

Recording = DS.Model.extend
  path: DS.attr 'string', {readOnly: true}
  created_at: DS.attr 'date', {readOnly: true}
  stream: DS.belongsTo 'stream'

  fullpath: (->
    "#{config.RECORD_ENDPOINT}/recordings/#{@get('path')}.mp4"
  ).property('path')

  imagepath: (->
    "#{config.RECORD_ENDPOINT}/images/#{@get('path')}.jpg"
  ).property('path')
  

`export default Recording`