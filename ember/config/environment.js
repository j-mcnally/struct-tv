/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'struct',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };
  ENV.WEBSOCKET_ENDPONT = ""

  if (environment === 'development') {
    //ENV.APP.LOG_RESOLVER = true;
    ENV.APP.LOG_ACTIVE_GENERATION = true;
    ENV.APP.LOG_TRANSITIONS = true;
    ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    ENV.APP.LOG_VIEW_LOOKUPS = true;
  
    ENV.APP_ENDPOINT = "http://struct.tv"
    ENV.STREAM_ENDPOINT = "http://localhost:8080"
    ENV.RECORD_ENDPOINT = "http://localhost:8080"

  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'auto';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;



    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {
    ENV.APP_ENDPOINT = "http://struct.tv"
    ENV.STREAM_ENDPOINT = "http://struct.tv"
    ENV.RECORD_ENDPOINT = "http://archive1.struct.tv"
    ENV.WEBSOCKET_ENDPONT = "ws://ws.struct.tv"
  }

  ENV['simple-auth'] = {
    authorizer: 'authorizer:elixir-github',
    store: 'simple-auth-session-store:local-storage'
  }


  return ENV;
};
