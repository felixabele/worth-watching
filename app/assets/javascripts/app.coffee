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
