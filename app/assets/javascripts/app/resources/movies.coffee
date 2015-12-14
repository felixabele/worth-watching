angular.module('app.resources')

.factory 'Movies', [ '$resource', ($resource) ->
  $resource "/api/movies/:id/:action", {id: '@id', action: '@action'},

    update:
      method:'PUT'

    update_movie_information:
      method:'PUT'
      params:
        action: 'update_movie_information'

]
