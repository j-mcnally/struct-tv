`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'index', { path: '/' }
  @route 'login'
  @route 'profile'
  @resource 'pages', ->
    @route 'show', { path: '/:id'}
  @resource 'streams', ->
    @route 'new'
    @route 'popular'
    @route 'following'
    @route 'show', { path: '/:id'}
  @resource 'channels', ->
    @route 'show', { path: '/:id'}

Router.reopen
  notifyGoogleAnalytics: (->
    window.ga('send', 'pageview', {
        'page': this.get('url'),
        'title': this.get('url')
      });
  ).on('didTransition')

`export default Router;`
