angular.module('app.controllers')

.controller 'MoviesCtrl', [
  '$scope'
  'Movies'

($scope, Movies) ->

  $scope.movies = []

  $scope.sort_type     = 'title'
  $scope.sort_reverse  = false
  $scope.search_term   = ''

  Movies.query (success) ->
    $scope.movies = success

  $scope.sort_column = (attr) ->
    $scope.sort_type = attr
    $scope.sort_reverse = !$scope.sort_reverse

]
