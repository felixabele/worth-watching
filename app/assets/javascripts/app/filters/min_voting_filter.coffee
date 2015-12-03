angular.module('app.filters')

.filter 'minVoting', [
  '$filter'

  ($filter) ->

    (list, min_vote) ->

      $filter('filter')(
        list, (val) ->
          val.information.vote_average >= min_vote)

]
