angular.module('app.filters')

.filter 'sinceDays', [
  '$filter'

  ($filter) ->

    (list, days) ->

      days_ago = (days) ->
        new Date().setDate(new Date().getDate() - days)

      $filter('filter')(
        list, (val) ->
          new Date(val.available_since) > days_ago(days))
]
