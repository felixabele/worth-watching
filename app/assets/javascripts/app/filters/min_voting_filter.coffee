angular.module('app.filters')

.filter 'minVoting', [
  '$filter'

  ($filter) ->

    (list, min_vote) ->

      $filter('filter')(
        list, (val) ->
          if val.information
            val.information.vote_average >= min_vote
          else
             0 >= min_vote
      )

]
