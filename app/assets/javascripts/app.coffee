#= require angular/angular
#= require angular-resource/angular-resource
#= require angular-utils-pagination
#= require angular-bootstrap

#= require_self
#= require_tree ./app/filters/
#= require_tree ./app/controllers/
#= require_tree ./app/resources/

app = angular.module('WorthWatching',[
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.resources'
  'app.services'
  'angularUtils.directives.dirPagination'
  'ui.bootstrap'
])

app.config [
  '$httpProvider'

  ($httpProvider) ->
    token = $("meta[name='csrf-token']").attr("content")
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = token
    $httpProvider.defaults.headers.common['Accept'] = 'application/json;q=0.9,text/plain;q=0.8,text/html;q=0.7'
]

angular.module 'app.controllers', []
angular.module 'app.directives', []
angular.module 'app.filters', []
angular.module 'app.resources', ['ngResource']
angular.module 'app.services', []
