Adhoq.hookCurrentTablesHelp = ($el)->
  $el.on 'click', ->
    $($el.data('inner')).load $el.attr('href'), ->
      $($el.data('target')).modal()

    false
