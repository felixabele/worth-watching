angular.module('app.controllers')

.controller 'MoviesCtrl', [
  '$scope'
  '$filter'
  'Movies'

($scope, $filter, Movies) ->

  $scope.movies = []

  $scope.options =
    min_vote: ['chose minimum rating',1,2,3,4,5,6,7,8,9]
    available_since: [
      {label: '3 Months', days: 90},
      {label: '1 Month',  days: 30},
      {label: '2 Weeks',  days: 14},
      {label: '1 Week',   days: 7},
    ]

  $scope.filter =
    min_vote: 0
    search_term: ''
    available_since: $scope.options.available_since[0]
    sort_reverse: false
    sort_type: 'title'

  Movies.query (success) ->
    $scope.movies = success

  $scope.sort_column = (attr) ->
    $scope.filter.sort_type = attr
    $scope.filter.sort_reverse = !$scope.filter.sort_reverse
]
