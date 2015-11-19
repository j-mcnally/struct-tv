ShareTwitterComponent = Ember.Component.extend
  tagName: 'a'
  classNames: ['twitter-share-button']
  attributeBindings: [
    'data-size', 'data-url', 
    'data-text', 'data-hashtags'
  ]

  didInsertElement: ->
    window.twttr.widgets.load()

`export default ShareTwitterComponent`