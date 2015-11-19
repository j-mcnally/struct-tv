/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp({
  sassOptions: {
    includePaths: [
      'bower_components/bootstrap-sass-official/assets/stylesheets',
      'bower_components/bootswatch-scss',
      'bower_components/slick.js/slick'
    ]
  },
  fingerprint: {
    enabled: false
  }
});


app.import('vendor/ember-simple-auth/simple-auth.amd.js', {
  exports: {
    'simple-auth/utils/get-global-config':                ['default'],
    'simple-auth/utils/is-secure-url':                    ['default']
  }
});

app.import('bower_components/bootstrap-sass-official/assets/javascripts/bootstrap.js')

app.import('bower_components/ic-autocomplete/dist/named-amd/main.js', {
  exports: {
    "ic-autocomplete/templates/autocomplete-css": ['default'],
    "ic-autocomplete/templates/autocomplete": ['default'],
    "ic-autocomplete/autocomplete": ['default'],
    "ic-autocomplete/autocomplete-option": ['default'],
    "ic-autocomplete/autocomplete-toggle": ['default'],
    "ic-autocomplete/autocomplete-input": ['default'],
    "ic-autocomplete/autocomplete-list": ['default']
  }
})

app.import('bower_components/ember-validations/index.js')
app.import('bower_components/marked/lib/marked.js')
app.import('bower_components/swfobject/swfobject/swfobject.js')
app.import('bower_components/swfobject/swfobject/swfobject.js')
app.import('bower_components/slick.js/slick/slick.min.js')
app.import('bower_components/mobile-detect/mobile-detect.min.js')

module.exports = app.toTree();