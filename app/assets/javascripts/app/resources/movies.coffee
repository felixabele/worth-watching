angular.module('app.resources')

.factory 'Movies', [ '$resource', ($resource) ->
  #$resource "#{window.relative_url_root}/satellite-db/satellites/:satellite_id_or_name", {},
]
