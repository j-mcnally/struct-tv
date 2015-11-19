Message = DS.Model.extend
  sender: DS.attr 'string', {readOnly: true}
  body: DS.attr 'string'
  stream: DS.belongsTo 'stream'
  

`export default Message`