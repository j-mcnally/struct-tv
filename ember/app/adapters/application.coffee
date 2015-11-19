ApplicationAdapter = DS.ActiveModelAdapter.extend
  namespace: "api/v1"
  ajaxError: (jqXHR) ->
    error = this._super(jqXHR)
    if (jqXHR && jqXHR.status == 401)
      document.location.href = '/logout'
    error

`export default ApplicationAdapter`