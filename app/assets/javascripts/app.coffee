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

angular.module 'app.controllers', []
angular.module 'app.directives', []
angular.module 'app.filters', []
angular.module 'app.resources', ['ngResource']
angular.module 'app.services', []
