angular.module('app.controllers')

.controller 'EditMovieCtrl', [
  '$scope'
  '$element'
  'Movies'

($scope, $element, Movies) ->

  $scope.movie = $element.data('movie')
  $scope.persisted_movie = angular.copy($scope.movie)
  $scope.title_alternatives_string = $scope.movie.title_alternatives.join(', ')

  $scope.$watch 'title_alternatives_string', ->
    $scope.movie.title_alternatives = $scope.title_alternatives_string
      .split(',').map (alt_title) -> alt_title.replace /^\s+|\s+$/g, ""

  $scope.attribute_changed = (attr) ->
    $scope.movie[attr] != $scope.persisted_movie[attr]

  $scope.update_title_alternatives = ->
    Movies.update(movie: $scope.movie) (success) ->
      $scope.movie = success
]
