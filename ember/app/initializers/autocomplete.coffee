`import autocompleteTemplate from 'ic-autocomplete/templates/autocomplete'`;
`import autocompleteCss from 'ic-autocomplete/templates/autocomplete-css'`;
`import AutocompleteComponent from 'ic-autocomplete/autocomplete'`;
`import AutocompleteOptionComponent from 'ic-autocomplete/autocomplete-option'`;
`import AutocompleteToggleComponent from 'ic-autocomplete/autocomplete-toggle'`;
`import AutocompleteInputComponent from 'ic-autocomplete/autocomplete-input'`;
`import AutocompleteListComponent from 'ic-autocomplete/autocomplete-list'`;

IcAutocomplete = 
  name: 'ic-autocomplete',
  initialize: (container) ->
    container.register('template:components/ic-autocomplete', autocompleteTemplate);
    container.register('template:components/ic-autocomplete-css', autocompleteCss);
    container.register('component:ic-autocomplete', AutocompleteComponent);
    container.register('component:ic-autocomplete-option', AutocompleteOptionComponent);
    container.register('component:ic-autocomplete-toggle', AutocompleteToggleComponent);
    container.register('component:ic-autocomplete-input', AutocompleteInputComponent);
    container.register('component:ic-autocomplete-list', AutocompleteListComponent);


`export default IcAutocomplete`;