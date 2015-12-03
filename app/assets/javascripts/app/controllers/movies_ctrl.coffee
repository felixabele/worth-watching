angular.module('app.controllers')

.controller 'MoviesCtrl', [
  '$scope'
  '$filter'
  'Movies'

($scope, $filter, Movies) ->

  $scope.movies = []

  $scope.options =
    ratings: ['chose minimum rating',1,2,3,4,5,6,7,8,9]

  $scope.filter =
    min_vote: 0
    search_term: ''
    sort_reverse: false
    sort_type: 'title'

  Movies.query (success) ->
    $scope.movies = success

  $scope.sort_column = (attr) ->
    $scope.filter.sort_type = attr
    $scope.filter.sort_reverse = !$scope.filter.sort_reverse

]
