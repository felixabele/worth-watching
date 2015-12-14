angular.module('app.controllers')

.controller 'EditMovieCtrl', [
  '$scope'
  '$element'
  'Movies'

($scope, $element, Movies) ->

  $scope.edit_movie =
    movie: {}
    persisted_movie: {}

  elapsed_days = (date) ->
    DAY = 1000 * 60 * 60  * 24
    d1 = new Date(date)
    d2 = new Date()
    Math.round(d2.getTime() - d1.getTime()) / DAY

  # outdated, missing, ok
  movie_information_status = (movie_information) ->
    if movie_information
      if elapsed_days(movie_information) > 7
        'outdated'
      else
        'ok'
    else
      'missing'

  $scope.$watch 'edit_movie.title_alternatives_string', ->
    if $scope.edit_movie.title_alternatives_string
      $scope.edit_movie.movie.title_alternatives = $scope.edit_movie.title_alternatives_string
        .split(',').map (alt_title) -> alt_title.replace /^\s+|\s+$/g, ""
    else
      $scope.edit_movie.movie.title_alternatives = []

  $scope.attribute_changed = (attr) ->
    !angular.equals($scope.edit_movie.movie[attr], $scope.edit_movie.persisted_movie[attr])

  $scope.update_title_alternatives = ->
    if $scope.attribute_changed('title_alternatives')

      Movies.update {
        id: $scope.edit_movie.movie.id,
        movie: $scope.edit_movie.movie
      }, (success) ->
        $scope.edit_movie.persisted_movie = success.movie

  $scope.update_movie_information = ->
    Movies.update_movie_information {
      id: $scope.edit_movie.movie.id
    }, (success) ->
      $scope.edit_movie.movie = success.movie
      $scope.edit_movie.persisted_movie = angular.copy($scope.edit_movie.movie)
      $scope.edit_movie.movie_information_status = movie_information_status($scope.edit_movie.movie.last_information_update)


  # --- load Movies from API
  Movies.get {
    id: $element.data('movie-id')
  }, (movie_data) ->
    $scope.edit_movie =
      movie: movie_data.movie
      persisted_movie: angular.copy(movie_data.movie)
      title_alternatives_string: movie_data.movie.title_alternatives?.join(', ')
      movie_information_status: movie_information_status(movie_data.movie.last_information_update)
]
