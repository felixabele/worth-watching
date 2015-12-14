angular.module('app.controllers')

.controller 'EditMovieCtrl', [
  '$scope'
  '$element'
  'Movies'

($scope, $element, Movies) ->

  Movies.get {
    id: $element.data('movie-id')
  }, (movie_data) ->
    $scope.edit_movie =
      movie: movie_data.movie
      persisted_movie: angular.copy(movie_data.movie)
      title_alternatives_string: movie_data.movie.title_alternatives?.join(', ')

  $scope.$watch 'edit_movie.title_alternatives_string', ->
    if $scope.edit_movie.title_alternatives_string
      $scope.edit_movie.movie.title_alternatives = $scope.edit_movie.title_alternatives_string
        .split(',').map (alt_title) -> alt_title.replace /^\s+|\s+$/g, ""

  $scope.attribute_changed = (attr) ->
    !angular.equals($scope.edit_movie.movie[attr], $scope.edit_movie.persisted_movie[attr])

  $scope.update_title_alternatives = ->
    if $scope.attribute_changed('title_alternatives')

      Movies.update {
        id: $scope.edit_movie.movie.id,
        movie: $scope.edit_movie.movie
      }, (success) ->
        $scope.edit_movie.persisted_movie = success.movie
]
