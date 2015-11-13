#= require angular/angular
#= require angular-resource/angular-resource

#= require_self
#= require_tree ./app/directives/
#= require_tree ./app/filters/
#= require_tree ./app/controllers/
#= require_tree ./app/resources/
#= require_tree ./app/services/
#= require_tree ./app/templates/

app = angular.module('WorthWatching',[
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.resources'
  'app.services'
])

angular.module 'app.controllers', []
angular.module 'app.directives', []
angular.module 'app.filters', []
angular.module 'app.resources', ['ngResource']
angular.module 'app.services', []
