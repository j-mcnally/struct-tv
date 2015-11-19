`import AuthenticatorBase from 'simple-auth/authenticators/base'`;
`import AuthorizerBase from 'simple-auth/authorizers/base'`;
`import getGlobalConfig from 'simple-auth/utils/get-global-config'`;
`import isSecureUrl from 'simple-auth/utils/is-secure-url'`;
`import Session from 'simple-auth/session'`;
`import config from '../config/environment'`

ElixirGithubAuthorizer = AuthorizerBase.extend
  authorize: (jqXHR, requestOptions) ->
    userToken = this.get('session.auth_token');
    if (this.get('session.isAuthenticated') && !Ember.isEmpty(userToken))
      if (!isSecureUrl(requestOptions.url))
        Ember.Logger.warn('Credentials are transmitted via an insecure connection - use HTTPS to keep them secure.');
      authData = 'token=' + userToken;
      jqXHR.setRequestHeader('Authorization', 'Token ' + authData);
    


ElixirGithubAuthenticator = AuthenticatorBase.extend
  serverTokenEndpoint: ''
  init: ->
    globalConfig             = getGlobalConfig('simple-auth-elixir-github');
    this.serverTokenEndpoint = globalConfig.serverTokenEndpoint || this.serverTokenEndpoint;
    # Check for token id
    

  restore: (properties) ->
    new Ember.RSVP.Promise((resolve, reject) ->
      if (!Ember.isEmpty(properties.auth_token))
        resolve(properties)
      else
        reject()
    )
  authenticate: (credentials) ->
    new Ember.RSVP.Promise((resolve, reject) ->
      if (!Ember.isEmpty(credentials.auth_token))
        resolve(credentials)
      else
        reject()
    )

ElixirGithubAuthenticatorInitializer =
  name: 'authentication',
  before: 'simple-auth',
  initialize: (container, application) ->
    Session.reopen
      currentUser: (->
        if @get('isAuthenticated')
          container.lookup('store:main').find('user', '~me')
      ).property('isAuthenticated')

    container.register('authenticator:elixir-github', ElixirGithubAuthenticator);
    container.register('authorizer:elixir-github', ElixirGithubAuthorizer)

`export default ElixirGithubAuthenticatorInitializer`