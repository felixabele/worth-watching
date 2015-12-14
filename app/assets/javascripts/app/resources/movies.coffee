angular.module('app.resources')

.factory 'Movies', [ '$resource', ($resource) ->
  $resource "/api/movies/:id", {id: '@movie.id'},

    update:
      method:'PUT'
]
