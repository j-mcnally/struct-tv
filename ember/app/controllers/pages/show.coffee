ShowController = Ember.Controller.extend
  page_content: (->
    marked(@get('page_body') || "")
  ).property('page_body')

`export default ShowController`