angular.module('app.resources')

.factory 'Movies', [ '$resource', ($resource) ->
  $resource "/api/movies/:movie_id", {},
]
