angular.module('app.resources')

.factory 'Movies', [ '$resource', ($resource) ->
  $resource "/api/movies/:id", {id: '@id'},

    update:
      method:'PUT'
]
