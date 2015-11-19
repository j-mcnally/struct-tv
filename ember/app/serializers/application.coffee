`import DS from 'ember-data'`

ApplicationSerializer = DS.ActiveModelSerializer.extend
  
  serializeAttribute: (record, json, key, attribute) ->
    # If the attribute is marked as transient
    # do not serialize and include in POST
    return if attribute.options.readOnly
    return @_super(record, json, key, attribute)

  serializeBelongsTo: (record, json, relationship) ->
    return if relationship.options.readOnly
    return @_super(record, json, relationship)

  serializeHasMany: (record, json, relationship) ->
    return if relationship.options.readOnly
    return @_super(record, json, relationship)

`export default ApplicationSerializer`